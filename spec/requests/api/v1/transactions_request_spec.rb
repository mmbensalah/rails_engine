require 'rails_helper'

describe 'Transaction API' do
  it 'should return all transactions' do
    create_list(:transaction, 10)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(10)
  end
  it 'should return one transaction' do
    test_transaction = create(:transaction)
    id               = test_transaction.id
    cc               = test_transaction.credit_card_number
    result           = test_transaction.result

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(cc)
    expect(transaction["data"]["attributes"]["result"]).to eq(result)
  end

  it 'returns a transaction by searching by id' do
    merchant     = Merchant.create(id: 1, name: "Merkel&Sons")
    customer     = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice      = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    transaction  = Transaction.create!(id: 1, invoice_id: 1)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["attributes"]["id"]).to eq(transaction.id)
  end

  it 'returns a transaction by searching by credit card number' do
    merchant     = Merchant.create(id: 1, name: "Merkel&Sons")
    customer     = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice      = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    transaction  = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "1111222233334444")

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"]["attributes"]["credit_card_number"]).to eq(transaction.credit_card_number)
  end
  it 'returns multiple transaction by searching by credit card number' do
    merchant      = Merchant.create(id: 1, name: "Merkel&Sons")
    customer      = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice       = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    transaction   = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "1111222233334444")
    transaction_1 = Transaction.create!(id: 2, invoice_id: 1, credit_card_number: "1111222233334444")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction.credit_card_number}"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)
    expect(transaction_parsed["data"][0]["attributes"]["credit_card_number"]).to eq(transaction.credit_card_number)
    expect(transaction_parsed["data"][1]["attributes"]["credit_card_number"]).to eq(transaction_1.credit_card_number)
  end
end
