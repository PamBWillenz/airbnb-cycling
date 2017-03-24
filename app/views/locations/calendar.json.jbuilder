json.array!(@location.reservations) do |reservation|
  json.title "Reservation #{reservation.id}"
  json.start reservation.start_date + 15.hours
  json.end reservation.end_date + 11.hours
end

json.array!(@location.future_available_dates) do |date|
  json.id date.id
  json.start date.available_date
  json.rendering "background"
  json.backgroundColor "blue"
end
