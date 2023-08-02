class AddTagRefToGossipTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :gossip_tags, :tag, null: false, foreign_key: { on_delete: :cascade }
  end
end
