require 'test_helper'

class AddressTest < ActiveSupport::TestCase
	# Run ActiveRecord macros
	# Relationships Tests
	# -------------------------------------
	should belong_to(:customer)
	should have_many(:orders)

	# Validation Tests
	# -------------------------------------
	should validate_presence_of(:recipient)
	should validate_presence_of(:street_1)
	should validate_presence_of(:zip)

	# State validations
	# -------------------------------------
	should allow_value("CA").for(:state)
	should allow_value("IL").for(:state)
	should allow_value("PA").for(:state)
	should allow_value("AZ").for(:state)

	should_not allow_value("WTF").for(:state)
	should_not allow_value("LOL").for(:state)
	should_not allow_value("Canada").for(:state)
	should_not allow_value("1").for(:state)

	# -------------------------------------
	context "Given context" do
		# create objects with factories
		setup do 
			create_customers
			create_addresses
		end

		# teardown method for removing objects as needed
		teardown do
			destroy_addresses
			destroy_customers
		end

		# checks to make sure the factory created the objects properly
		should "show that all setup objects were made correctly" do 
			# address objects
			assert_equal "5000 Forbes Ave", @cmu_dtsong.street_1
			assert_equal "12219 Fairway Pointe Row", @sd.street_1
			assert_equal "1400 Montefino Ave", @liferay.street_1
			assert_equal "121 Blake Ave", @usna.street_1

			assert_equal "Daniel Song", @cmu_dtsong.recipient
			assert_equal "Jun Song", @sd.recipient
			assert_equal "Peter Bugbee", @liferay.recipient
			assert_equal "Joshua Elliott", @usna.recipient
			assert @cmu_dtsong.active 
			assert @sd.active 
			assert @liferay.active 
			deny @usna.active 
			# customer objects
			assert_equal "Daniel", @daniel.first_name
	  	  	assert_equal "Russell", @russell.first_name
	  	  	assert_equal "Sibo", @sibo.first_name
	        assert_equal "Peter", @peter.first_name
	        assert_equal "Jun", @jun.first_name
	        assert_equal "Joshua", @joshua.first_name
	        assert @joshua.active
	  	  	assert @daniel.active
	  	  	assert @russell.active
	  	  	deny @peter.active
	  	  	deny @sibo.active
		end

		# tests the 'active' scope 
		should "show that there are five active addresses in Bread Express" do 
			assert_equal ["5000 Forbes Ave", "5000 Forbes Ave", "12219 Fairway Pointe Row", "1400 Montefino Ave", "5801 S Ellis Ave"], Address.active.map { |a| a.street_1  }
		end

		# tests the 'inactive' scope
		should "show that there is one inactive address in Bread Express" do 
			assert_equal ["121 Blake Ave"], Address.inactive.map { |a| a.street_1 }
		end 

		# tests the 'by_recipient' scope
		should "sort the addresses alphabetically by recipient" do 
			assert_equal "5000 Forbes Ave", Address.by_recipient.first.street_1
			assert_equal "5801 S Ellis Ave", Address.by_recipient.last.street_1
		end 

		# tests the 'by_customer' scope
		should "sort the addresses by customer's last name and first name" do 
			assert_equal "1400 Montefino Ave", Address.by_customer.first.street_1
			assert_equal "12219 Fairway Pointe Row", Address.by_customer.last.street_1		
		end

		# tests the 'shipping' scope
		should "return all addresses that are just shipping addresses" do 
			assert_equal ["1400 Montefino Ave", "121 Blake Ave", "5801 S Ellis Ave"], Address.shipping.map { |a| a.street_1 }
		end

		# tests the 'billing' scope
		should "return all addresses that are also billing addresses" do 
			assert_equal ["5000 Forbes Ave", "5000 Forbes Ave", "12219 Fairway Pointe Row"], Address.billing.map { |a| a.street_1 }
		end
	end
end
