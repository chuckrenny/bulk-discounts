class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  validates :status, presence: true

  enum :status, {"in progress": 0, "completed": 1, "cancelled": 2}

  def date_format
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    self.invoice_items.sum("quantity * unit_price")
  end

  def total_revenue_after_discounts
    self.total_revenue - self.invoice_items.joins(item: {merchant: :bulk_discounts})
    .where("invoice_items.quantity >= bulk_discounts.threshold")
    .select('invoice_items.*', 'bulk_discounts.percentage_off', 'bulk_discounts.threshold')
    .sum("invoice_items.quantity * (invoice_items.unit_price * bulk_discounts.percentage_off/100.0)") 
  end
end