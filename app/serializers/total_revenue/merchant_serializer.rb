class TotalRevenue::MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name

  attribute :most_revenue do |merchant|
    (merchant.most_revenue.round(2)/100.00).to_s
  end
end
