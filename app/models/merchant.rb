class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(quantity = 5)
    unscoped.
    select("merchants.*, SUM(invoice_items.quantity * items.unit_price) AS total_revenue")
    .joins(items: :invoice_items)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = 5)
    unscoped.
    select("merchants.*, SUM(invoice_items.quantity) AS total_items")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order("total_items DESC")
    .limit(quantity)
  end

  def self.revenue_by_date(date)
    unscoped.
    select("merchants.*, SUM(invoice_items.quantity * items.unit_price) AS total_revenue")
    .joins(items: :invoice_items)
    .where(invoices: {created_at: date.to_date.beginning_of_day..date.to_date.end_of_day})
    .group(:id)
    .order(:id)
  end
end
