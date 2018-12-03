class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 5)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total")
    .joins(:invoice_items)
    .group(:id)
    .order("total DESC")
    .limit(quantity)
    # SELECT items.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS total FROM items
      # INNER JOIN invoice_items ON invoice_items.item_id = items.id
        # GROUP BY items.id
          # ORDER BY total DESC
            # LIMIT(quantity);
  end

  def self.most_items(quantity = 5)
    select("items.*, SUM(invoice_items.quantity) AS total")
    .joins(:invoice_items)
    .group(:id)
    .order("total DESC")
    .limit(quantity)
    # SELECT items.id, SUM(invoice_items.quantity) AS total FROM items
	  #  INNER JOIN invoice_items ON invoice_items.item_id = items.id
	  #   GROUP BY items.id
	  #    ORDER BY total DESC;
  end

  def self.best_day(id)
    select("invoices.*")
    .joins(invoice_items: :invoice)
    .where(id: id)
    .order("invoice_items.quantity DESC")
    .first
    .created_at
    # SELECT * FROM items
	  #  INNER JOIN invoice_items ON invoice_items.item_id = items.id
	  #   WHERE items.id = 1099
	  #    ORDER BY invoice_items.quantity DESC;
  end
end
