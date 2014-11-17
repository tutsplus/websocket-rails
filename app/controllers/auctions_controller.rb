class AuctionsController < ApplicationController
  def create
    product = Product.find params[:product_id]
    auction = Auction.new auction_params.merge! product_id: product.id

    if auction.save
      redirect_to product, notice: "Product was put to auction."
    else
      redirect_to product, alert: "Something went wrong, please review your data."
    end
  end

  def auction_params
    params.require(:auction).permit(:value, :ends_at)
  end
end
