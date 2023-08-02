class AddCityRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :city, null: false, foreign_key: { on_delete: :cascade }
  end
end
