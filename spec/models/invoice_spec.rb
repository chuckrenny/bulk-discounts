require "rails_helper"

RSpec.describe Invoice, type: :model do
  before :each do
    @date = DateTime.new(2012, 3, 10)
    @invoice1 = create(:invoice, created_at: @date) # automatically create associated customer, transactions and invoice_items
  end
  describe "relationships" do
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe "instance methods" do
    describe "#date_format" do
      it "can return the created_at date formatted as 'day_of_week, full_month padded_day, year'" do
        expect(@invoice1.date_format).to eq("Saturday, March 10, 2012")
      end
    end

    describe "#total_revenue" do
      it "can find the total revenue on an invoice" do
        item1 = create(:item, unit_price: 100)
        item2 = create(:item, unit_price: 200)
        create(:invoice_item, invoice: @invoice1, item: item1, quantity: 2, unit_price: 100)
        create(:invoice_item, invoice: @invoice1, item: item2, quantity: 3, unit_price: 200)

        expect(@invoice1.total_revenue).to eq(800)
      end
    end

    #Bulk US-6
    describe "#total_revenue_after_discounts" do
      it "can find the total revenue after applicable discounts" do
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

        expect(@invoice1.total_revenue).to eq(205)
        expect(@invoice1.total_revenue_after_discounts).to eq(170)
      end
    end
  end
end