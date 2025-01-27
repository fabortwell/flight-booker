class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @dates = Flight.available_dates
    @passenger_options = [ 1, 2, 3, 4 ]

    return unless params[:commit] == "Search"

    @selected_flights = Flight.where(departure_airport_id: params[:departure_airport_id])
                              .where(arrival_airport_id: params[:arrival_airport_id])
                              .where("DATE(departure_time) = ?", params[:date])
  end
end
