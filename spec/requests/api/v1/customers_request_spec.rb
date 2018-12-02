require 'rails_helper'

describe 'Customers API' do
  it 'should return all customers' do
    create_list(:customer, 10)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(10)
  end

  it 'should return one customer' do
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

  it 'returns a customer by searching by first name' do
    customer = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"]["attributes"]["first_name"]).to eq(customer.first_name)
  end

  it 'returns a customer by searching by last name' do
    customer = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"]["attributes"]["last_name"]).to eq(customer.last_name)
  end

  it 'returns a customer by searching for id' do
    customer = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")

    get "/api/v1/customers/find?id=#{customer.id}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"]["attributes"]["id"]).to eq(customer.id)
  end

  it 'returns multiple customers by searching by first name' do
    customer   = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    customer_1 = Customer.create(id: 2, first_name: "Rainy", last_name: "Night")

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"][0]["attributes"]["first_name"]).to eq(customer.first_name)
    expect(customer_parsed["data"][1]["attributes"]["first_name"]).to eq(customer_1.first_name)
  end

  it 'returns multiple customers by searching by last name' do
    customer   = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    customer_1 = Customer.create(id: 2, first_name: "Stormy", last_name: "Day")

    get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"][0]["attributes"]["last_name"]).to eq(customer.last_name)
    expect(customer_parsed["data"][1]["attributes"]["last_name"]).to eq(customer_1.last_name)
  end
end
