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
end
