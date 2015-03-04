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
			create_orders
			create_customers
			create_addresses
		end

		# destroy objects as needed
		teardown do 
			destroy_addresses
			destroy_customers
			destroy_orders
		end

		should "put orders in chronological order by date" do 

		end 

		should "return all orders that have been paid" do 

		end

		should "return all orders for a given customer" do 

		end 

		should "ensure that customer_ids will be limited to existing active customers" do

		end

		should "ensure that address_ids will be limited to existing active addresses" do 

		end

		should "ensure that the pay method is working as it should" do 

		end
	end 
end
