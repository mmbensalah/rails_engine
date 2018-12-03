class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    invoice = InvoiceItem.find(params[:id]).invoice
    render json: InvoiceSerializer.new(invoice)
  end
end
