json.array!(@location.future_available_dates) do |date|
  json.start date.date
  json.rendering 'background'
end

