class Article < ApplicationRecord
  validates :title, :body, :user, presence: true
  belongs_to :user
  belongs_to :category, default: "uncategorized"
  has_many :votes
end
