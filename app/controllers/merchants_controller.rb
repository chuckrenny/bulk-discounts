class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    # @invoice = Invoice.find(params[:merchant_id])
    # @item = Item.find(params[:merchant_id])
    @top_customers = @merchant.top_five_customers
  end
end
