class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  has_many :articles
end
