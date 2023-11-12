class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_off, :threshold, presence: true
end