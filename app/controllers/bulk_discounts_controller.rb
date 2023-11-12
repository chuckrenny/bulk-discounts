class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = BulkDiscount.all
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new 
    @bulk_discount = BulkDiscount.new
    @merchants = Merchant.all
  end

  def create
    merchant = Merchant.find(params[:merchant_id])

    merchant.bulk_discounts.create!({
      percentage_off: params[:percentage_off],
      threshold: params[:threshold]
    })

    redirect_to bulk_discounts_path
  end
end