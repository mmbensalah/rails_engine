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

  it 'returns all transactions associated with an invoice' do
    merchant      = Merchant.create(id: 1, name: "Merkel&Sons")
    customer      = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice       = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    transaction   = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "1111222233334444")
    transaction_1 = Transaction.create!(id: 2, invoice_id: 1, credit_card_number: "1111222233334444")
    transaction_2 = Transaction.create!(id: 3, invoice_id: 1, credit_card_number: "1111222233334444")

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transaction_parsed = JSON.parse(response.body)

    expect(transaction_parsed["data"][0]["attributes"]["id"]).to eq(transaction.id)
    expect(transaction_parsed["data"][1]["attributes"]["id"]).to eq(transaction_1.id)
    expect(transaction_parsed["data"][2]["attributes"]["id"]).to eq(transaction_2.id)
  end

  it 'returns all invoice items associated with an invoice' do
    merchant       = Merchant.create(id: 1, name: "Merkel&Sons")
    customer       = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice        = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    invoice_item   = create(:invoice_item, invoice_id: 1)
    invoice_item_1 = create(:invoice_item, invoice_id: 1)
    invoice_item_2 = create(:invoice_item, invoice_id: 1)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_item_parsed = JSON.parse(response.body)

    expect(invoice_item_parsed["data"][0]["attributes"]["id"]).to eq(invoice_item.id)
    expect(invoice_item_parsed["data"][1]["attributes"]["id"]).to eq(invoice_item_1.id)
    expect(invoice_item_parsed["data"][2]["attributes"]["id"]).to eq(invoice_item_2.id)
  end

  it 'returns all items associated with an invoice' do
    merchant       = Merchant.create(id: 1, name: "Merkel&Sons")
    customer       = Customer.create(id: 1, first_name: "Rainy", last_name: "Day")
    invoice        = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)
    item           = create(:item, id: 1)
    item_1         = create(:item, id: 2)
    item_2         = create(:item, id: 3)
    invoice_item   = create(:invoice_item, id: 1, item_id: 1, invoice_id: 1)
    invoice_item_1 = create(:invoice_item, id: 2, item_id: 2, invoice_id: 1)
    invoice_item_2 = create(:invoice_item, id: 3, item_id: 3, invoice_id: 1)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items_parsed = JSON.parse(response.body)

    expect(items_parsed["data"][0]["attributes"]["id"]).to eq(item.id)
    expect(items_parsed["data"][1]["attributes"]["id"]).to eq(item_1.id)
    expect(items_parsed["data"][2]["attributes"]["id"]).to eq(item_2.id)
  end

  it 'returns the customer associated with an invoice' do
    merchant       = Merchant.create(id: 1, name: "Merkel&Sons")
    customer       = create(:customer, id: 1)
    invoice        = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customer_parsed = JSON.parse(response.body)

    expect(customer_parsed["data"]["attributes"]["id"]).to eq(customer.id)
  end
  it 'returns the merchant associated with an invoice' do
    merchant       = Merchant.create(id: 1, name: "Merkel&Sons")
    customer       = create(:customer, id: 1)
    invoice        = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchant_parsed = JSON.parse(response.body)

    expect(merchant_parsed["data"]["attributes"]["id"]).to eq(merchant.id)
  end
end
