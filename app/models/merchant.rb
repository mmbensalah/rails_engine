class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(quantity = 5)
    select("merchants.*, SUM(invoice_items.quantity * items.unit_price) AS total_revenue")
    .joins(items: :invoice_items)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end
end
