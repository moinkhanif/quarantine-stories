class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category, default: "uncategorized"
  has_many :votes
end
