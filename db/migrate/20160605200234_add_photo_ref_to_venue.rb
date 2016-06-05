class AddPhotoRefToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :photo_refernce, :string
  end
end
