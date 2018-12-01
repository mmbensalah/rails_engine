require 'rails_helper'

describe 'Customers API' do
  it 'should return all customers' do
    create_list(:customer, 10)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(10)
  end

  it 'should one customer' do
    test_customer = create(:customer)
    id            = test_customer.id
    first_name    = test_customer.first_name
    last_name     = test_customer.last_name

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["id"]).to         eq(id)
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
    expect(customer["data"]["attributes"]["last_name"]).to  eq(last_name)
  end
end
