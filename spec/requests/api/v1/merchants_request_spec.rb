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

  xit 'returns a merchant by searching by name' do
    merchant = Merchant.create!(id: 1, name: "Merkel&Sons")

    get "/api/v1/merchants/find?name=Merkel&Sons"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)

    expect(merchant_parsed["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it 'returns a merchant by searching for id' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)
    expect(merchant_parsed["data"]["attributes"]["id"]).to eq(merchant.id)
  end

  it 'returns multiple merchants by searching for id' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)

    expect(merchant_parsed["data"][0]["attributes"]["id"]).to eq(merchant.id)
  end

  it 'returns all items associated w/ one merchant' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    item     = create(:item, merchant_id: 1)
    item_1   = create(:item, merchant_id: 1)
    item_2   = create(:item, merchant_id: 1)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)

    expect(merchant_parsed["data"][0]["id"]).to eq(item.id.to_s)
    expect(merchant_parsed["data"][1]["id"]).to eq(item_1.id.to_s)
    expect(merchant_parsed["data"][2]["id"]).to eq(item_2.id.to_s)
  end
  it 'returns all invoices associated w/ one merchant' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    invoice     = create(:invoice, merchant_id: 1)
    invoice_1   = create(:invoice, merchant_id: 1)
    invoice_2   = create(:invoice, merchant_id: 1)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)

    expect(merchant_parsed["data"][0]["id"]).to eq(invoice.id.to_s)
    expect(merchant_parsed["data"][1]["id"]).to eq(invoice_1.id.to_s)
    expect(merchant_parsed["data"][2]["id"]).to eq(invoice_2.id.to_s)
  end
end
