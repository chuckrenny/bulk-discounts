require 'rails_helper'

RSpec.describe "BulkDiscount Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
  end

  #Bulk US-2
  it "displays a form to create a new discount" do
    visit new_bulk_discount_path

    expect(page).to have_content("Add a New Discount")

    select(@merchant1.name, from: 'Merchant')
    fill_in :percentage_off, with: 10
    fill_in :threshold, with: 5

    click_on 'Create New Discount'

    expect(current_path).to eq(bulk_discounts_path)
    expect(page).to have_content("Percentage Off: 10")
    expect(page).to have_content("Quantity Threshold: 5")
  end
end