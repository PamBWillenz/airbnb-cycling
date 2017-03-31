json.array!(@reservations) do |date|
  location = date.location
  json.title "#{location.title}
  #{date.start_date.strftime("%m/%d/%Y")}"
  json.start date.start_date + 15.hours
  json.end date.end_date + 11.hours
end
