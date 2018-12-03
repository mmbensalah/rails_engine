class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: TotalRevenue::MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
end
