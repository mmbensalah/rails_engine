FactoryBot.define do
  factory :customer do
    sequence :first_name {|n| "rain_#{n}"}
    sequence :last_name {|n| "storm_#{n}"}
  end
end
