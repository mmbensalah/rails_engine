class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    customer = Invoice.find(params[:id]).customer

    render json: CustomerSerializer.new(customer)
  end
end
