class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  private

  def _params
    params.permit(:number, :date, :departure_city, :arrival_city)
  end
end
