require 'rails_helper'

RSpec.describe 'Airlines Show Page' do
  before :each do
    @airline = Airline.create!(name: "Frontier")

    @flight_1 = @airline.flights.create!(number: "1234", date: "4/23/21", departure_city: "Denver", arrival_city: "Reno")
    @flight_2 = @airline.flights.create!(number: "5678", date: "4/27/21", departure_city: "Nashville", arrival_city: "Los Angeles")
    @flight_3 = @airline.flights.create!(number: "910", date: "4/24/21", departure_city: "Atlanta", arrival_city: "Dallas")

    @passenger_1 = Passenger.create!(name: "Andrew", age: 18)
    @passenger_2 = Passenger.create!(name: "Joe", age: 7)
    @passenger_3 = Passenger.create!(name: "Emily", age: 37)
    @passenger_4 = Passenger.create!(name: "Mark", age: 59)
    @passenger_5 = Passenger.create!(name: "Kathy", age: 58)
    @passenger_6 = Passenger.create!(name: "Jane", age: 3)

    Ticket.create!(flight: @flight_1, passenger: @passenger_1)
    Ticket.create!(flight: @flight_1, passenger: @passenger_2)

    Ticket.create!(flight: @flight_2, passenger: @passenger_3)
    Ticket.create!(flight: @flight_2, passenger: @passenger_4)
    Ticket.create!(flight: @flight_2, passenger: @passenger_1)

    Ticket.create!(flight: @flight_3, passenger: @passenger_5)
    Ticket.create!(flight: @flight_3, passenger: @passenger_6)
    Ticket.create!(flight: @flight_3, passenger: @passenger_1)

    visit "/airlines/#{@airline.id}"
  end

  describe 'I visit an airlines show page' do
    it 'can see list of unique passengers 18 years old or over with flights on this airline' do
      expect(page).to have_content(@passenger_1.name, count: 1)
      expect(page).to have_content(@passenger_3.name, count: 1)
      expect(page).to have_content(@passenger_4.name, count: 1)
      expect(page).to have_content(@passenger_5.name, count: 1)

      expect(page).not_to have_content(@passenger_2.name)
      expect(page).not_to have_content(@passenger_6.name)
    end
  end
end
