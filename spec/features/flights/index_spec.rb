require 'rails_helper'

RSpec.describe 'Flights Index Page' do
  before :each do
    @airline_1 = Airline.create!(name: "Frontier")
    @airline_2 = Airline.create!(name: "United")
    @airline_3 = Airline.create!(name: "Southwest")

    @flight_1 = @airline_1.flights.create!(number: "1234", date: "4/23/21", departure_city: "Denver", arrival_city: "Reno")
    @flight_2 = @airline_2.flights.create!(number: "5678", date: "4/27/21", departure_city: "Nashville", arrival_city: "Los Angeles")
    @flight_3 = @airline_3.flights.create!(number: "910", date: "4/24/21", departure_city: "Atlanta", arrival_city: "Dallas")

    @passenger_1 = Passenger.create!(name: "Andrew", age: 35)
    @passenger_2 = Passenger.create!(name: "Joe", age: 7)
    @passenger_3 = Passenger.create!(name: "Emily", age: 37)
    @passenger_4 = Passenger.create!(name: "Mark", age: 59)
    @passenger_5 = Passenger.create!(name: "Kathy", age: 58)
    @passenger_6 = Passenger.create!(name: "Jane", age: 3)

    Ticket.create!(flight: @flight_1, passenger: @passenger_1)
    Ticket.create!(flight: @flight_1, passenger: @passenger_2)
    Ticket.create!(flight: @flight_2, passenger: @passenger_3)
    Ticket.create!(flight: @flight_2, passenger: @passenger_4)
    Ticket.create!(flight: @flight_3, passenger: @passenger_5)
    Ticket.create!(flight: @flight_3, passenger: @passenger_6)
    visit "/flights"
  end

  describe 'when I visit the flights index page' do
    it 'can see a list of all flight numbers' do
      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_2.number)
      expect(page).to have_content(@flight_3.number)
    end

    it ' can see the name of the airline next to each flight number' do
      within("#flight-#{@flight_1.id}") do
        expect(page).to have_content(@airline_1.name)
      end

      within("#flight-#{@flight_2.id}") do
        expect(page).to have_content(@airline_2.name)
      end

      within("#flight-#{@flight_3.id}") do
        expect(page).to have_content(@airline_3.name)
      end
    end

    it 'see the names of all passengers for the flight under each flight number' do
      within("#flight-#{@flight_1.id}") do
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
      end

      within("#flight-#{@flight_2.id}") do
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_4.name)
      end

      within("#flight-#{@flight_3.id}") do
        expect(page).to have_content(@passenger_5.name)
        expect(page).to have_content(@passenger_6.name)
      end
    end
  end
end

# User Story 1, Flights Index Page
#
# As a visitor
# When I visit the flights index page
# I see a list of all flight numbers
# And next to each flight number I see the name of the Airline of that flight
# And under each flight number I see the names of all that flight's passengers
