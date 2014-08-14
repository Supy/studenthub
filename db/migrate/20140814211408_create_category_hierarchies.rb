class CreateCategoryHierarchies < ActiveRecord::Migration
    def change
        create_table :category_hierarchies, id: false do |t|
            t.integer  :ancestor_id, null: false
            t.integer  :descendant_id, null: false
            t.integer  :generations, null: false
        end

        # For "all progeny of…" and leaf selects:
        add_index :category_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'tag_anc_desc_udx'

        # For "all ancestors of…" selects,
        add_index :category_hierarchies, [:descendant_id], name: 'tag_desc_idx'
    end
end
