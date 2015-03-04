require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	# Runs ActiveRecord macros
  	# Relationship Tests
  	# ----------------------------------------
  	should belong_to(:address)
  	should belong_to(:customer)

  	# Validation Tests
  	# ----------------------------------------
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

		# should "ensure that customer_ids will be limited to existing active customers" do

		# end

		# should "ensure that address_ids will be limited to existing active addresses" do 

		# end

		# should "ensure that the pay method is working as it should" do 

		# end
	end 
end
