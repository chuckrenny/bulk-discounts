require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before :each do
    # @customer = create(:customer)
    # @invoice1 = create(:invoice, customer: @customer, status: 0)
    
    # Create first item and associated invoice item
    # @item1 = create(:item) 
    # @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    
    # Create second item and associated invoice item
    # @item2 = create(:item) 
    # @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @item2)

    # Create a transaction for the invoice
    # create(:transaction, invoice: @invoice1) 
    @merchant1 = create(:merchant, enabled: true)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)
    @item3 = create(:item, merchant: @merchant1)

    @customer1 = create(:customer)

    @invoice1 = create(:invoice, customer: @customer1)

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: 10, quantity: 5)
    @invoice_item1 = create(:invoice_item, item: @item2, invoice: @invoice1, unit_price: 5, quantity: 1)
    @invoice_item1 = create(:invoice_item, item: @item3, invoice: @invoice1, unit_price: 15, quantity: 10)

    @bulk1 = create(:bulk_discount, percentage_off: 10, threshold: 5, merchant: @merchant1)
    @bulk2 = create(:bulk_discount, percentage_off: 20, threshold: 10, merchant: @merchant1)
  end

  # US 33
  it "lists all of the invoice details on the show page" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("ID: ##{@invoice1.id}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
    expect(page).to have_content("Created Date: #{@invoice1.date_format}")
  end

  # US 34
  it "displays all invoice items and attributes" do
    visit admin_invoice_path(@invoice1.id)

    @invoice1.invoice_items.each do |invoice_item|
      within("#invoice-item-#{invoice_item.id}") do
        expect(page).to have_content("Item: #{invoice_item.item.name}")
        expect(page).to have_content("Quantity Ordered: #{invoice_item.quantity}")
        expect(page).to have_content("Sold Price: #{invoice_item.unit_price}")
        expect(page).to have_content("Invoice Item Status: #{invoice_item.status}")
      end
    end
  end 

  # US 35
  it "displays the total revenue generated from the invoice" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("Total Revenue: $#{@invoice1.total_revenue}")
  end

  # US 36
  it "displays a select field for invoice status and updates the field" do
    visit admin_invoice_path(@invoice1.id)

    expect(@invoice1.status).to eq("in progress")

    select "completed", from: "status"
    click_button "Update Invoice Status"

    @invoice1.reload

    expect(@invoice1.status).to eq("completed")
  end

  #Bulk US-8
  describe "Admin Invoice Show Page: Total and Discounted Revenue" do
    it "displays total revenue for admin from the invoice before discounts" do
      visit admin_invoice_path(@invoice1) 

      expect(page).to have_content("Total revenue: $205.00")
    end

    it "displays the discounted revenue from the admin invoice with the bulk discounts included" do
      visit admin_invoice_path(@invoice1) 

      expect(page).to have_content("Total Revenue after Discounts(if applicable): $170.00")
    end
  end
end 