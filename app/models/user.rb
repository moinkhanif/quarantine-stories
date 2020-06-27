class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy
end
