class CreateBlacklist < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.integer :member_id
      t.integer :venue_id
    end
  end
end
