class PlaceBid
  attr_reader :auction, :status

  def initialize options
    @value = options[:value].to_f
    @user_id = options[:user_id].to_i
    @auction_id = options[:auction_id].to_i
  end

  def execute
    @auction = Auction.find @auction_id

    if auction.ended? && auction.top_bid.user_id == @user_id
      @status = :won
      return false
    end

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
