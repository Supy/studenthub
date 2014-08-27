class RenameAccomodationToAccommodation < ActiveRecord::Migration
  def change
      rename_table :accomodations, :accommodations
      rename_column :accommodations, :accomodation_type, :accommodation_type
  end
end
