class Search < ApplicationRecord
  validates_uniqueness_of :url
  validates_presence_of :url

  def self.ordered_by_creation(ordered_by)
    if ordered_by == "newist"
      self.order("created_at DESC")
    elsif ordered_by == "oldest"
      self.order("created_at ASC")
    else
      []
    end
  end
end
