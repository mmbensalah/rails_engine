class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    invoice_items = Invoice.find(params[:id]).invoice_items

    items         = invoice_items.map do |object|
                      Item.find(object.item_id)
                    end
    render json: ItemSerializer.new(items)
  end
end
