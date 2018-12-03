class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    merchant = Invoice.find(params[:id]).merchant

    render json: MerchantSerializer.new(merchant)
  end
end
