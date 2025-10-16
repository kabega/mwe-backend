class Bid < ApplicationRecord
  validates :title, presence: true
  validates :bid_type, presence: true
end
