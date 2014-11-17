class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params.merge! user_id: current_user.id)
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  def transfer
    product = Product.find params[:id]
    if product.auction.ended?
      product.update_attribute :user_id, product.auction.top_bid.user_id
      redirect_to product, notice: "Successfully transfered the product."
    else
      redirect_to product, alert: "The auction hasn't ended yet."
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :image)
    end
end
