class Advert < ActiveRecord::Base
    """
    An Advert is an individual item being sold/given away. The advert has a
    :title, :description, and :category_id along with :field_values that match
    the field definition for its category, and a :price_type that encodes one
    of [exact, free, swap, poa], the :price variable is only needed if
    :price_type is exact
    """

    # has a category
    belongs_to :category

    # field_values is a Hash
    serialize :field_values, Hash

    # price_type is an enum
    enum price_type: [:exact_price, :free, :swap, :price_on_application]

    after_initialize :default_values

    validates :title, presence: true, allow_blank: false
    validates :title, length: {minimum: 5, maximum: 100}
    validates :description, presence: true, allow_blank: false
    validates :description, length: {minimum: 10, maximum: 10000}

    validates :price, presence: true, if: :exact_price?
    validates :price, numericality: { greater_than: 0, less_than: 10_000_000 }, if: :exact_price?

    validates :category, presence: true
    validate :field_values_must_match_field_def

    private

        def default_values
            self.price_type ||= :exact_price
        end

        def field_values_must_match_field_def

            field_definition = category.build_fields

            field_definition.each do |name, attributes|
                if attributes.include? 'required' and attributes['required'] == true and not field_values.include? name
                    errors.add(:field_values, "Missing value for required field #{name}.")
                end

                if attributes.include? 'select' and field_values.include? name and not attributes['select'].include? field_values[name]
                    errors.add(:field_values, "Value for #{name} is not one of the available options.")
                end
            end

        end
end
