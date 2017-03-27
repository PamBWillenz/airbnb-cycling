json.array! (@location.future_booked_dates) do |date|
  json.start date.start_date
  json.end date.end_date
  json.rendering 'background'
end

json.array!(@location.future_available_dates) do |date|
  json.start date.available_date
  json.rendering 'background'
end

