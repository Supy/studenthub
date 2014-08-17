class Category < ActiveRecord::Base
    """
    Category is made to define a type of advert with a number of arbitrary
    fields attached to it. eg: A book has an author/publisher/ISBN.

    Categories can be joined in a tree structure so that children inherit the
    fields defined by a parent Category. eg: A Car inherits a Make & Model field
    from its parent Motor Vehicle.

    Fields:
        name:   The name of the field. Must be present and must be at least 3
                characters and preferably plural.

        fields: The definition of the category's fields. This is serialized as
                JSON. eg:
                [
                    'field_1': {
                        'required': true,
                        'select': ['A', 'B', 'C']
                    },
                    'field_2': { },
                    'field_3': {
                        'required': true
                    }
                ]

                'required' indicates that a value MUST be present for that field
                'select' indicates that the value MUST be one of the values in
                    the following array.

                The GUI should indicate these via a * for required fields, and
                by using a drop down for selectables.

    """

    # (add any attr_accessible here)

    acts_as_tree order: 'name'

    # the fields value is a serialized hash
    serialize :fields, Hash

    after_initialize :default_values

    # validations
    validates :name, presence: true, allow_blank: false
    validates :name, length: {minimum: 3}
    validates :fields, presence: true, allow_blank: true
    validate :cant_have_duplicate_sibling, :must_have_valid_field_definition

    def build_fields
        """
        Build the final field definition by combining the fields with
        the fields of all ancestors
        """
        final_fields = fields
        ancestors.each do |ancestor|
            final_fields = ancestor.fields.merge(final_fields)
        end
        final_fields
    end

    private

        def default_values
            fields ||= {}
        end

        def cant_have_duplicate_sibling
            if siblings.index {|s| s.name == name}
                errors.add(:name, 'Name conflicts with an adjacent category in the tree.')
            end
        end

        def must_have_valid_field_definition
            # blank field names
            if fields.include? ''
                errors.add(:fields, "Can't have blank fields.")
            end

            # duplicate field names
            dups = fields.keys - fields.keys.uniq
            if not dups.empty?
                errors.add(:fields, "Duplicate field names: #{dups.join(', ')}.")
            end

            fields.each do |field_name, field_attrs|
                # field options can only be 'required' or 'select'
                unknowns = field_attrs.keys - ['required', 'select']
                if not unknowns.empty?
                    errors.add(:fields, "Unknown field attributes on #{field_name}: #{unknowns.join(', ')}.")
                end

                if field_attrs.include? 'select' and field_attrs['select'].empty?
                    errors.add(:fields, "Field #{field_name} selectables cannot be empty.")
                end
            end
        end
end
