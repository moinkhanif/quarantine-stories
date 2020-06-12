class Vote < ApplicationRecord
  validates :user, :article, presence: true
  belongs_to :article
  belongs_to :user
end
