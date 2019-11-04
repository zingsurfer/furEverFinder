class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.text :url, null: false

      t.timestamps null: false
    end

    add_index :searches, :url, unique: true
  end
end
