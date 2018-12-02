require 'rails_helper'

describe 'Items API' do
  it 'should return all items' do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(10)
  end

  it 'should return one item' do
    test_item   = create(:item)
    id          = test_item.id
    name        = test_item.name
    description = test_item.description

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["name"]).to eq(name)
    expect(item["data"]["attributes"]["description"]).to eq(description)
  end

  it 'returns an item by searching by name' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    item =     Item.create!(id: 1, merchant_id: 1, name: "Glass Bottle", description: "c. 1890", unit_price: 200, )

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)

    expect(item_parsed["data"][0]["attributes"]["name"]).to eq(item.name)
  end

  it 'returns an item by searching by description' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    item =     Item.create!(id: 1, merchant_id: 1, name: "Glass Bottle", description: "c. 1890", unit_price: 200, )

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"][0]["attributes"]["description"]).to eq(item.description)
  end

  it 'returns an item by searching by id' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    item =     Item.create!(id: 1, merchant_id: 1, name: "Glass Bottle", description: "c. 1890", unit_price: 200, )

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item_parsed = JSON.parse(response.body)
    expect(item_parsed["data"][0]["attributes"]["id"]).to eq(item.id)
  end
end
