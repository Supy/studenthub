class CreateAccomodations < ActiveRecord::Migration
    def change
        create_table :accomodations do |t|
            t.string :title
            t.text :description

            t.integer :accomodation_type
            t.integer :dwelling_type
            t.integer :size_sqm
            t.integer :bedrooms
            t.integer :bathrooms
            t.integer :parking_type

            t.float :price
            t.date :available_from

            t.boolean :pets_allowed
            t.boolean :smoking_allowed
            t.integer :preferred_gender

            t.integer :advertiser_type

            t.integer :share_type

            t.integer :places_available

            t.integer :location_id

            t.timestamps
        end
    end
end
