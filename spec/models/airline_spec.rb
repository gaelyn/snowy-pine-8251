require 'rails_helper'

RSpec.describe Airline, type: :model do
  it {should have_many :flights}
  it { should have_many(:passengers).through(:flights) }
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
  end

  describe 'instance methods' do
    describe '.adult_passengers' do
      it 'can list only adult passengers 18 or over with no duplicates' do
        expect(@airline.adult_passengers).to eq([@passenger_1, @passenger_3, @passenger_4, @passenger_5])
        expect(@airline.adult_passengers).not_to include(@passenger_2)
        expect(@airline.adult_passengers).not_to include(@passenger_6)
      end

      it 'can sort passengers by number of flights from most to least' do
        @passenger_7 = Passenger.create!(name: "Kevin", age: 40)
        @flight_4 = @airline.flights.create!(number: "1112", date: "5/24/21", departure_city: "Huntville", arrival_city: "Houston")
        Ticket.create!(flight: @flight_4, passenger: @passenger_1)
        Ticket.create!(flight: @flight_4, passenger: @passenger_3)
        Ticket.create!(flight: @flight_4, passenger: @passenger_5)
        Ticket.create!(flight: @flight_4, passenger: @passenger_7)

        Ticket.create!(flight: @flight_1, passenger: @passenger_5)
        Ticket.create!(flight: @flight_2, passenger: @passenger_5)
        
        expect(@airline.adult_passengers).to eq([@passenger_1, @passenger_5, @passenger_3, @passenger_4, @passenger_7])
      end
    end
  end
end
