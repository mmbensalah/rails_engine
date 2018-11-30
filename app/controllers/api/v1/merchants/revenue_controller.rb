class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.revenue_by_date(params[:date]))
  end
end
