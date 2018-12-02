class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
  end

  private

  def invoice_item_params
    params.permit(:id, :merchant_id, :customer_id, :created_at, :updated_at)
  end
end
