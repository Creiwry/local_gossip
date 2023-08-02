class CreateGossipTags < ActiveRecord::Migration[7.0]
  def change
    create_table :gossip_tags do |t|

      t.timestamps
    end
  end
end
