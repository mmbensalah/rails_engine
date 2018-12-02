class Api::V1::Merchants::InvoicesController < ApplicationController
  def show
    merchant = Merchant.find(params[:id]).invoices
    render json: InvoiceSerializer.new(merchant)
  end
end
