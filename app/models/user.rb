class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy
end
