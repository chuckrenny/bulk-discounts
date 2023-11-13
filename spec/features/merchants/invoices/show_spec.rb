require "rails_helper"

RSpec.describe "merchant invoice show page" do
  # before :each do
  #   @merchant_1 = create(:merchant)
  #   @merchant_2 = create(:merchant)
  #   @invoice_1 = create(:invoice)
  #   @customer_1 = create(:customer)
  #   @customer_2 = create(:customer)
  #   @customer_3 = create(:customer)
  #   @customer_4 = create(:customer)
  #   @customer_5 = create(:customer)
  #   @customer_6 = create(:customer)
  #   @customer_7 = create(:customer)
  #   @invoice_1 = create(:invoice, customer: @customer_1)
  #   @invoice_2 = create(:invoice, customer: @customer_2)
  #   @invoice_3 = create(:invoice, customer: @customer_3)
  #   @invoice_4 = create(:invoice, customer: @customer_4)
  #   @invoice_5 = create(:invoice, customer: @customer_5)
  #   @invoice_6 = create(:invoice, customer: @customer_6)
  #   @invoice_7 = create(:invoice, customer: @customer_7)
  #   @item_1 = create(:item, merchant: @merchant_1)
  #   @item_2 = create(:item, merchant: @merchant_1)
  #   @item_3 = create(:item, merchant: @merchant_1)
  #   @item_4 = create(:item, merchant: @merchant_1)
  #   @item_5 = create(:item, merchant: @merchant_1)
  #   @item_6 = create(:item, merchant: @merchant_1)
  #   @item_7 = create(:item, merchant: @merchant_2)
  #   @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, unit_price: 50_000, quantity: 2)
  #   @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
  #   @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
  #   @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
  #   @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
  #   @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, status: 2)
  #   @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item_7)
  #   @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
  #   @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
  #   @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
  #   @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
  #   @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
  #   @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
  # end

  before :each do
    # @merchant1 = create(:merchant, enabled: true)
    # @merchant2 = create(:merchant, enabled: true)
    # @merchant3 = create(:merchant, enabled: true)
    # @merchant4 = create(:merchant)
    # @merchant5 = create(:merchant)

    # @customer1 = create(:customer)
    # @customer2 = create(:customer)
    # @customer3 = create(:customer)
    # @customer4 = create(:customer)
    # @customer5 = create(:customer)

    # @invoice1 = create(:invoice, customer: @customer1, created_at: "2023-11-07 00:04:06.477179000 +0000")
    # @invoice2 = create(:invoice, customer: @customer2, created_at: "2020-10-02 00:04:06.477179000 +0000")
    # @invoice3 = create(:invoice, customer: @customer3)
    # @invoice4 = create(:invoice, customer: @customer4)
    # @invoice5 = create(:invoice, customer: @customer5)

    # @item1 = create(:item, merchant: @merchant1)
    # @item2 = create(:item, merchant: @merchant2)
    # @item3 = create(:item, merchant: @merchant3)
    # @item4 = create(:item, merchant: @merchant4)
    # @item5 = create(:item, merchant: @merchant5)

    # # Create invoice items with unit prices and quantities associated with invoices
    # @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: 10, quantity: 5)
    # @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice2, unit_price: 15, quantity: 3)
    # @invoice_item3 = create(:invoice_item, item: @item3, invoice: @invoice3, unit_price: 8, quantity: 5)
    # @invoice_item4 = create(:invoice_item, item: @item4, invoice: @invoice4, unit_price: 9, quantity: 4)
    # @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice5, unit_price: 9, quantity: 2)

    # # Create successful transactions for invoices
    # @transaction1 = create(:transaction, invoice: @invoice1, result: 0) # Successful
    # @transaction2 = create(:transaction, invoice: @invoice2, result: 0) # Successful
    # @transaction3 = create(:transaction, invoice: @invoice3, result: 0) # Successful
    # @transaction4 = create(:transaction, invoice: @invoice4, result: 0) # Successful
    # @transaction5 = create(:transaction, invoice: @invoice5, result: 0) # Successful

    # @bulk1 = create(:bulk_discount, percentage_off: 10, threshold: 5, merchant: @merchant1)

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

  #US 15
  describe "Merchant Invoice Show Page" do
    xit "Shows invoice information" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.date_format)
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end
  end

  #US 16
  describe "Merchant Invoice Show Page: Invoice Item Information" do
    xit "shows items on the invoice related to the merchent" do
      visit"/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to_not have_content(@item_7.name)
    end

    xit "Shows total revenue generated for an invoice" do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content("Total revenue: $1,000.00")

    end
  end

  #US 18
  describe "Merchant Invoice Show Page: Update Item Status" do
    xit "select field and update button" do
      visit"/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      
      
      within("#item_status") do
        click_button("Update Item Status")
      end

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    end
  end
  
  #Bulk US-6
  describe "Merchant Invoice Show Page: Total and Discounted Revenue" do
    it "displays total revenue for merchant from the invoice before discounts" do
      visit merchant_invoice_path(@merchant1, @invoice1) 

      expect(page).to have_content("Total revenue: $205.00")
    end

    it "displays the discounted revenue from the merchant invoice with the bulk discounts included" do
      visit merchant_invoice_path(@merchant1, @invoice1) 

      expect(page).to have_content("Total Revenue after Discounts(if applicable): $170.00")
    end
  end

  #Bulk US-7
  describe "Merchant Invoice Show Page: Link to Applied Discounts" do
    it "displays a link to the bulk discount show page if a discount was applied" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      within("#item_status") do
        expect(page).to have_link("Discount Show Page")
        click_link("Discount Show Page")
        expect(current_path).to eq(bulk_discount_path(@bulk1))
      end
    end
  end
end