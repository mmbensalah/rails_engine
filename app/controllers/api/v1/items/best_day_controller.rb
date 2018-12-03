class Api::V1::Items::BestDayController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.best_day(params[:id]))
  end
end
