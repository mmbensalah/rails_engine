require 'rails_helper'

RSpec.describe Item do
  describe "class methods" do
    it "#most_revenue" do
      item   = create(:item, unit_price: 100)
      item_1 = create(:item, unit_price: 200)
      item_2 = create(:item, unit_price: 300)
      invoice = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item, quantity: 5)
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_1, quantity: 1)
      invoice_item_3 = create(:invoice_item, invoice: invoice, item: item_2, quantity: 1)

      expect(Item.most_revenue(3).first.id).to eq(item.id)
    end
    it "#most_items" do
      item   = create(:item, unit_price: 100)
      item_1 = create(:item, unit_price: 200)
      item_2 = create(:item, unit_price: 300)
      invoice = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item, quantity: 5)
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_1, quantity: 2)
      invoice_item_3 = create(:invoice_item, invoice: invoice, item: item_2, quantity: 1)

      expect(Item.most_items(3).first.id).to eq(item.id)
      expect(Item.most_items(3).last.id).to eq(item_2.id)
    end

    # it "#most_items" do
    #   item   = create!(:item, unit_price: 100)
    #   invoice   = create!(:invoice, id: 1)
    #   invoice_1 = create!(:invoice, id: 2)
    #   invoice_2 = create!(:invoice, id: 3)
    #   invoice_item_1 = create!(:invoice_item, invoice: invoice, item: item, quantity: 5)
    #   invoice_item_2 = create!(:invoice_item, invoice: invoice, item: item, quantity: 2)
    #   invoice_item_3 = create!(:invoice_item, invoice: invoice, item: item, quantity: 1)
    #
    #   expect(Item.best_day(item.id).to eq(invoice)
    # end
  end
end
