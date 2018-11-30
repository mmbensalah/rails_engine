require 'rails_helper'

RSpec.describe Invoice do
  describe "class methods" do
    it "#invoice_total" do
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice: invoice, quantity: 2, unit_price: 5)
    invoice_item_2 = create(:invoice_item, invoice: invoice, quantity: 4, unit_price: 2)
    invoice_item_3 = create(:invoice_item, invoice: invoice, quantity: 3, unit_price: 3)

    id = invoice.id
    expect(Invoice.invoice_total(id)).to eq(27)
    end
  end
end
