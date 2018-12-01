require 'rails_helper'

describe "Merchant API" do
  it 'returns a list of all merchants' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(10)
  end

  it 'returns one merchant' do
    test_merchant = create(:merchant)
    id            = test_merchant.id
    name          = test_merchant.name

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["id"]).to   eq(id)
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end
end
