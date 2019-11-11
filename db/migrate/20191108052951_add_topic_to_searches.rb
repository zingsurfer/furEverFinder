class AddTopicToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :topic, :string, default: 'misc'
  end
end
