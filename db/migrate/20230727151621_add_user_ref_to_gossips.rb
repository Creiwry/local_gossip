class AddUserRefToGossips < ActiveRecord::Migration[7.0]
  def change
    add_reference :gossips, :user, null: false, foreign_key: { on_delete: :cascade }
  end
end
