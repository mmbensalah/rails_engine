FactoryBot.define do
  factory :item do
    sequence :name {|n| "item_#{n}"}
    description "object"
    unit_price 5
    merchant
  end
end
