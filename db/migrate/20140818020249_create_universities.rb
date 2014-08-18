class CreateUniversities < ActiveRecord::Migration
    def change
        create_table :universities do |t|
            t.string :name
            t.string :short_name
            t.float :latitude
            t.float :longitude

            t.timestamps
        end
    end
end
