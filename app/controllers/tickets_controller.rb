class TicketsController < ApplicationController
  def destroy
    @passenger = Passenger.find(params[:id])
    @flight = Flight.find(params[:flight_id])
    Ticket.where(flight: @flight, passenger: @passenger).destroy_all
    redirect_to "/flights"
  end
end
