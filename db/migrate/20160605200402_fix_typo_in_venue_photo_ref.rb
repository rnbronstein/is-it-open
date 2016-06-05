class FixTypoInVenuePhotoRef < ActiveRecord::Migration
  def change
    rename_column :venues, :photo_refernce, :photo_reference
  end
end
