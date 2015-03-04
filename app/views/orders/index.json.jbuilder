json.array!(@orders) do |order|
  json.extract! order, :id, :date, :customer_id, :address_id, :grand_total, :payment_receipt
  json.url order_url(order, format: :json)
end
