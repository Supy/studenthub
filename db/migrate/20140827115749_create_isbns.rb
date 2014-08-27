class CreateIsbns < ActiveRecord::Migration
  def change
    create_table :isbns do |t|
      t.string :isbn, limit: 13
      t.references :book, index: true
    end
  end
end
