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
end
