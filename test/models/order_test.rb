require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	# Runs ActiveRecord macros
  	# Relationship Tests
  	# ----------------------------------------
  	should belong_to(:address)
  	should belong_to(:customer)

  	# Validation Tests
  	# ----------------------------------------
  	should allow_value(24.65).for(:grand_total)
  	should allow_value(3).for(:grand_total)
  	should_not allow_value("WOW").for(:grand_total)
  	should_not allow_value(0).for(:grand_total)
  	should_not allow_value(-10000).for(:grand_total)
  	should_not allow_value(10.404).for(:grand_total)

  	should allow_value(Date.today).for(:date)
	should allow_value(1.day.ago.to_date).for(:date)
	should allow_value(1.day.from_now.to_date).for(:date)
	should_not allow_value("bad").for(:date)
	should_not allow_value(2).for(:date)
	should_not allow_value(3.14159).for(:date)

	# ----------------------------------------
	context "Given context" do 
		# create objects from factories
		setup do 
			create_customers
			create_addresses
			create_orders
		end

		# destroy objects as needed
		teardown do 
			destroy_orders
			destroy_addresses
			destroy_customers
		end

		should "put orders in chronological order by date" do 
			assert_equal ["2015-03-03", "2015-03-04", "2015-03-05", "2015-03-09"], Order.chronological.map { |o| o.date.to_s }
		end 

		should "return all orders that have been paid" do 
			@daniel_1.pay
			@russell_1.pay
			assert_equal 2, Order.paid.to_a.size
		end

		should "return all orders for a given customer" do 
			assert_equal 2, Order.for_customer(@daniel).size
		end 

		# test the custom validation 'customer_is_active_in_Bread_Express'
		should "ensure that customer_ids will be limited to existing active customers" do
			# Sibo is inactive while the address is active
      		# Using .build to ensure the bad data doesn't end the test early
			inactive_customer_order = FactoryGirl.build(:order, address: @dtsong_cmu, customer: @sibo)
			deny inactive_customer_order.valid?
		end

		# test the custom validation 'address_is_active_in_Bread_Express'
		should "ensure that address_ids will be limited to existing active addresses" do 
			# LifeRay's address is inactive while customer is active
			inactive_address_order = FactoryGirl.build(:order, address: @liferay, customer: @daniel)
			deny inactive_address_order.valid?
		end

		should "ensure that the pay method is working" do 
			# directly make the encoded string using the base64 code for Order.first record
			first_order_to_encode = "order: " + Order.first.id.to_s + "; amount_paid: " + Order.first.grand_total.to_s + "; received: " + Order.first.date.to_s
			first_encoded_string = Base64.encode64(first_order_to_encode)
			# do likewise for Order.last record
			last_order_to_encode = "order: " + Order.last.id.to_s + "; amount_paid: " + Order.last.grand_total.to_s + "; received: " + Order.last.date.to_s
			last_encoded_string = Base64.encode64(last_order_to_encode)

			# 'pay' should insert an encrypted string into 'payment_receipt' in the order record
			Order.first.pay 
			Order.last.pay 

			# ensure that the string inserted is as it was in the rails console.
			assert_equal first_encoded_string, Order.first.payment_receipt
			assert_equal last_encoded_string, Order.last.payment_receipt
		end
	end 
end
