class Search < ApplicationRecord
  before_save { topic.downcase! }

  validates_uniqueness_of :url
  validates_presence_of :url

  scope :topic_filtered, -> (topic) {where(topic: topic)}
  scope :topic_sorted, -> () {order(topic: :asc)}

  # TODO: find a better way to handle this
  def self.creation_ordered(order)
    if order == "newist_created"
      self.order(created_at: :desc)
    elsif order == "oldest_created"
      self.order(created_at: :asc)
    end
  end
end
