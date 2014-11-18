require "test_helper"
require "place_bid"

class PlaceBidTest < MiniTest::Test
  def setup
    @user = User.create! email: "tutsplus@josemota.net", password: "password"
    @another_user = User.create! email: "another_user@josemota.net", password: "password"
    @product = Product.create! name: "Some Product"
    @auction = Auction.create! value: 10, product_id: product.id, ends_at: (Time.now + 24.hours)
  end

  def test_it_places_a_bid
    service = PlaceBid.new(
      value: 11,
      user_id: another_user.id,
      auction_id: auction.id
    )

    service.execute

    assert_equal 11, auction.current_bid
  end

  def test_fails_to_place_bid_under_current_value
    service = PlaceBid.new(
      value: 9,
      user_id: another_user.id,
      auction_id: auction.id
    )

    refute service.execute, "Bid should not be placed"
  end

  def test_notifies_if_auction_has_won
    service = PlaceBid.new(
      value: 11,
      user_id: user.id,
      auction_id: auction.id
    )

    service.execute

    another_service = PlaceBid.new(
      value: 9001,
      user_id: user.id,
      auction_id: auction.id
    )

    Timecop.travel Time.now + 25.hours
    another_service.execute

    assert_equal :won, another_service.status
  end

  private

  attr_reader :user, :another_user, :product, :auction
end
