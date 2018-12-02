class Api::V1::Invoices::FindController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where(invoice_params))
  end

  private

  def invoice_params
    params.permit(:id, :merchant_id, :customer_id, :created_at, :updated_at)
  end
end
