class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :uid
      t.string :name
    end
  end
end
