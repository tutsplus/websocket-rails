class PlaceBid
  def initialize options
    @value = options[:value].to_f
    @user_id = options[:user_id]
    @auction_id = options[:auction_id]
  end

  def execute
    auction = Auction.find @auction_id

    if @value <= auction.current_bid
      return false
    end

    bid = auction.bids.build value: @value, user_id: @user_id

    if bid.save
      return true
    else
      return false
    end
  end
end
