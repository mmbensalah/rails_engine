class TotalRevenue::ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name,
             :description,
             :merchant_id
  attribute :total_revenue do |item|
    (item.total_revenue.round(2)/100.00).to_s
  end
end
