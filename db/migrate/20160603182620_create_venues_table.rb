class CreateVenuesTable < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :google_place_id
    end
  end
end
