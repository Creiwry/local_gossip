class CreateGossips < ActiveRecord::Migration[7.0]
  def change
    create_table :gossips do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
