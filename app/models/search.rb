class Search < ApplicationRecord
  validates_uniqueness_of :url
  validates_presence_of :url
end
