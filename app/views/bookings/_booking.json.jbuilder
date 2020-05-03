json.extract! booking, :id, :client_name, :date_start, :date_end, :created_at, :updated_at
json.url booking_url(booking, format: :json)
