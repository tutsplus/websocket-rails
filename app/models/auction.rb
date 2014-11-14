class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids

  def top_bid
    bids.order(value: :desc).first
  end

  def current_bid
    top_bid.nil? ? value : top_bid.value
  end
end
