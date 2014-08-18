class DropAdvertCategoryLocationTables < ActiveRecord::Migration
    def change
        drop_table :adverts
        drop_table :categories
        drop_table :category_hierarchies
    end
end
