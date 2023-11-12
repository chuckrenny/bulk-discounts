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
    merchant = Merchant.find(bulk_discount_params[:merchant_id])

    bulk_discount = merchant.bulk_discounts.build(bulk_discount_params)

    if bulk_discount.save
      redirect_to bulk_discounts_path, notice: "Discount created successfully"
    else
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
      render :new
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])

    bulk_discount.destroy if bulk_discount
    
    redirect_to bulk_discounts_path
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])

    if bulk_discount.update(bulk_discount_params)
      redirect_to bulk_discounts_path, notice: "Discount successfully updated"
    else
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
      render :edit
    end
  end

  private
  
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_off, :threshold, :merchant_id)
  end
end