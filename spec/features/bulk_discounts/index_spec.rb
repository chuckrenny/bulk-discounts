require 'rails_helper'

RSpec.describe "BulkDiscount Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @bulk1 = create(:bulk_discount, merchant: @merchant1)
    @bulk2 = create(:bulk_discount, merchant: @merchant1)
    @bulk3 = create(:bulk_discount, merchant: @merchant2)
    @bulk4 = create(:bulk_discount, merchant: @merchant2)
  end

  #Bulk US-1
  it "displays all bulk discounts including their attributes and a redirect link to the show page" do
    visit bulk_discounts_path

    [@bulk1, @bulk2, @bulk3, @bulk4].each do |bulk|
      within("#bulk-#{bulk.id}") do
        expect(page).to have_content("Percentage Off: #{bulk.percentage_off}")
        expect(page).to have_content("Quantity Threshold: #{bulk.threshold}")

        expect(page).to have_link("Bulk ID-#{bulk.id} Show Page")
        click_link("Bulk ID-#{bulk.id} Show Page")

        expect(current_path).to eq(bulk_discount_path(bulk.id))
        visit bulk_discounts_path
      end
    end
  end
end