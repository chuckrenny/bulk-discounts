class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :quantity, :unit_price, :status, presence: true
  
  enum :status, {pending: 0, packaged: 1, shipped: 2}

  def self.items_to_ship
    joins(:invoice)
    .where.not(status: 2)
    .select('id', 'invoices.id as invoice_id', 'invoice_items.status', 'invoices.created_at')
    .order('invoices.created_at ASC')
  end

  def applicable_discount
    item.merchant.bulk_discounts
        .where("bulk_discounts.threshold <= ?", quantity)
        .order(percentage_off: :desc)
        .first
  end
end