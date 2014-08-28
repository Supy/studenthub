class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.references :book, index: true
      t.integer :edition, limit: 1
      t.integer :price, limit: 2
      t.integer :condition, limit: 1
      t.text :comments

      t.timestamps
    end
    add_index :textbooks, :edition
    add_index :textbooks, :price
  end
end
