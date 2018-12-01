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
end
