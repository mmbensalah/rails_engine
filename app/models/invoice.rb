class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.invoice_total(id)
    joins(:invoice_items)
    .where(id: id)
    .sum("quantity * unit_price")
  end
end
