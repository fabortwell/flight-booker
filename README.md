# Flight Booking System

A Ruby on Rails application that allows users to search for available flights and select one for booking.


## Features

- **Search Flights**: Filter flights by departure/arrival airports, date, and number of passengers.
- **Real-Time Results**: View matching flights instantly on the same page.
- **Simple Booking Flow**: Select a flight and proceed to booking (next step in flow).

## Setup

1. **Clone the repository**:
   ```bash
   git clone git@github.com:fabortwell/flight-booker.git
   cd flight-booker
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Setup the database**:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # Populates airports and sample flights
   ```

4. **Start the server**:
   ```bash
   rails server
   ```
   Visit `http://localhost:3000` in your browser.

---

## Project Structure

### Models

#### `Airport`
- **Fields**: `code` (string, e.g., "SFO")
- **Associations**:
  ```ruby
  has_many :departing_flights, class_name: "Flight", foreign_key: :departure_airport_id
  has_many :arriving_flights, class_name: "Flight", foreign_key: :arrival_airport_id
  ```

#### `Flight`
- **Fields**: 
  - `departure_airport_id` (references Airport)
  - `arrival_airport_id` (references Airport)
  - `start` (datetime)
  - `duration` (integer, in minutes)
- **Associations**:
  ```ruby
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  ```
- **Scopes**:
  ```ruby
  # Example query method in Flight model
  def self.search(departure_code, arrival_code, date)
    departure_airport = Airport.find_by(code: departure_code)
    arrival_airport = Airport.find_by(code: arrival_code)
    start_date = date.to_date.beginning_of_day
    end_date = date.to_date.end_of_day

    where(departure_airport: departure_airport, arrival_airport: arrival_airport)
      .where(start: start_date..end_date)
      .order(:start)
  end
  ```

---

### Controllers

#### `FlightsController`
- **`index` Action**:
  - Handles search parameters (`departure_code`, `arrival_code`, `date`, `num_passengers`).
  - Returns matching flights to the view.
  - Maintains the search form on the page.

#### `BookingsController` (Next Step)
- **`new` Action**: 
  - Will handle flight selection and passenger details (future implementation).

---

### Views

#### `flights/index.html.erb`
- **Search Form**:
  - Dropdowns for departure/arrival airports (populated from `Airport.all`).
  - Date selector limited to dates with existing flights.
  - Passenger selector (1-4).
  - Submits via `GET` to show results on the same page.

- **Search Results**:
  - Displays flights matching the criteria.
  - Each flight is a radio button in a form that submits to `bookings#new`.
  - Hidden field retains the number of passengers.

---

## Routes

```ruby
root 'flights#index'
resources :flights, only: [:index]
resources :bookings, only: [:new, :create]  # Further implementation needed
```

---

## Usage

1. **Search Flights**:
   - Select departure/arrival airports, date, and passengers.
   - Click "Search Flights".

2. **Select a Flight**:
   - Choose from the list of available flights.
   - Click "Book Flight" to proceed (next step in booking flow).

---

## Testing

- **Sample Data**: Seeded airports include SFO, NYC, LAX, etc.
- **Sample Flights**: Random flights are generated with `db/seeds.rb`.
- **Example Search**:
  - Departure: SFO
  - Arrival: NYC
  - Date: Select a date from the dropdown.

---

## Improvements (Future Work)

- Add user authentication.
- Integrate payment processing.
- Add flight duration display and layover information.
- Implement AJAX for smoother search interactions.
