require 'rails_helper'

RSpec.describe "Bulk Discounts Show Page" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @bulk1 = create(:bulk_discount, percentage_off: 15, threshold: 5, merchant: @merchant1)
    @bulk2 = create(:bulk_discount, merchant: @merchant1)
    @bulk3 = create(:bulk_discount, merchant: @merchant2)
    @bulk4 = create(:bulk_discount, merchant: @merchant2)
  end

  #Bulk US-4
  it "displays the bulk discount's quantity threshold and percentage discount" do
    visit bulk_discount_path(@bulk1)

    expect(page).to have_content("#{@merchant1.name}: Bulk Discount ID##{@bulk1.id} Show Page")
    expect(page).to have_content("Percentage Off: #{@bulk1.percentage_off}")
    expect(page).to have_content("Quantity Threshold: #{@bulk1.threshold}")
  end

  #Bulk US-5
  it "displays a link to edit the discount" do
    visit bulk_discount_path(@bulk1)

    expect(page).to have_link("Edit Discount")
    click_link("Edit Discount")
    expect(current_path).to eq(edit_bulk_discount_path(@bulk1))
  end
end