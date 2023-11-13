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
    # require 'pry';binding.pry
    self.total_revenue - invoice_items.joins(item: { merchant: :bulk_discounts })
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .group('invoice_items.id')
    .pluck(Arel.sql('MAX(bulk_discounts.percentage_off) * invoice_items.unit_price * (invoice_items.quantity / 100.0)'))
    .sum
  end
end