require 'rails_helper'

RSpec.describe BulkDiscount, type: :feature do
  before :each do
    @merchant1 = create(:merchant)

    @bulk1 = create(:bulk_discount, percentage_off: 15, threshold: 5, merchant: @merchant1)
  end
  
  #Bulk US-5
  it "displays a form to edit bulk discount" do
    visit edit_bulk_discount_path(@bulk1)

    fill_in 'Percentage off', with: 30
    fill_in 'Threshold', with: 10
    click_button "Update Discount"

    expect(current_path).to eq(bulk_discounts_path)
    expect(page).to have_content("Percentage Off: 30")
    expect(page).to have_content("Quantity Threshold: 10")
  end
end