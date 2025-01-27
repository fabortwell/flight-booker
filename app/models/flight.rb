class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  def self.available_dates
    pluck("DATE(departure_time)").uniq
  end
end
