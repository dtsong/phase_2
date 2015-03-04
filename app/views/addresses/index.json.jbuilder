json.array!(@addresses) do |address|
  json.extract! address, :id, :customer_id, :is_billing, :recipient, :street_1, :street_2, :city, :state, :zip, :active
  json.url address_url(address, format: :json)
end
