class DropAdvertCategoryLocationTables < ActiveRecord::Migration
    def change
        drop_table :adverts
        drop_table :categories
        drop_table :locations
        drop_table :category_hierarchies
        drop_table :location_hierarchies
    end
end
