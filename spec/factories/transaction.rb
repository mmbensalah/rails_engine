FactoryBot.define do
  factory :transaction do
    invoice
    sequence :credit_card_number {|n| "1111-2222-3333-4444#{n}"}
    result "success"
  end
end
