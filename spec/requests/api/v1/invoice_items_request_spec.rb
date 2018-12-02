require 'rails_helper'

describe 'InvoiceItems API' do
  it 'should return all invoice items' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(10)
  end

  it 'should return one invoice item' do
    test_invoice_item = create(:invoice_item)
    id                = test_invoice_item.id
    quantity          = test_invoice_item.quantity
    unit_price        = test_invoice_item.unit_price

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(unit_price)
  end

  it 'returns an invoice item by searching by id' do
    merchant     = Merchant.create(id: 1, name: "Merkel&Sons")
    customer     = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    item         = Item.create!(id: 1, merchant_id: 1, name: "Glass Bottle", description: "c. 1890", unit_price: 200 )
    invoice      = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    invoice_item = InvoiceItem.create!(id: 1, item_id: 1, invoice_id: 1, quantity: 5, unit_price: 2000)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)
    expect(invoice_item_parsed["data"]["attributes"]["id"]).to eq(invoice_item.id)
  end
end
