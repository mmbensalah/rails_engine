require 'rails_helper'

describe 'Invoices API' do
  it 'should return all invoices' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(10)
  end

  it 'should return one invoice' do
    test_invoice = create(:invoice)
    id           = test_invoice.id
    status       = test_invoice.status

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"]["attributes"]["status"]).to eq(status)
  end

  it 'returns an invoice by searching by id' do
    merchant = Merchant.create(id: 1, name: "Merkel&Sons")
    customer = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice  = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    expect(response).to be_successful

    invoice_parsed = JSON.parse(response.body)

    expect(invoice_parsed["data"]["attributes"]["id"]).to eq(invoice.id)
  end
end
