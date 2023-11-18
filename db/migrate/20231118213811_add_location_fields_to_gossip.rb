class AddLocationFieldsToGossip < ActiveRecord::Migration[7.0]
  def change
    add_column :gossips, :longitude, :float
    add_column :gossips, :latitude, :float
  end
end
