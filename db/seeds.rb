Airport.create!([ { code: 'SFO' }, { code: 'NYC' }, { code: 'LAX' }, { code: 'CHI' }, { code: 'MIA' } ])

flights_data = [
  { departure_airport: 'SFO', arrival_airport: 'NYC', departure_time: Time.now + 1.day, flight_duration: 320 },
  { departure_airport: 'NYC', arrival_airport: 'LAX', departure_time: Time.now + 2.days, flight_duration: 280 }
  # Add more flights...
]

flights_data.each do |data|
  departure = Airport.find_by(code: data[:departure_airport])
  arrival = Airport.find_by(code: data[:arrival_airport])
  Flight.create!(
    departure_airport: departure,
    arrival_airport: arrival,
    departure_time: data[:departure_time],
    flight_duration: data[:flight_duration]
  )
end
