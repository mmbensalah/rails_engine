FactoryBot.define do
  factory :merchant do
    sequence :name {|n| "merchant_#{n}"}
  end
end
