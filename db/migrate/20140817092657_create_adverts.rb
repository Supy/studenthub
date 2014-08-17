class CreateAdverts < ActiveRecord::Migration
    def change
        create_table :adverts do |t|
            t.string :title
            t.text :description
            t.integer :category_id
            t.text :fieldvalues
            t.float :price
            t.integer :price_type
        end
    end
end
