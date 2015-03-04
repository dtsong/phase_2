module Contexts
	module Customers
	# Context for customers
		def create_customers
	  	  	@daniel = FactoryGirl.create(:customer)
	  	  	@russell = FactoryGirl.create(:customer, first_name: "Russell", last_name: "Lee", email: "rlee@example.com", phone: "412-304-3495", active: true)
	  	  	@sibo = FactoryGirl.create(:customer, first_name: "Sibo", last_name: "Cai", email: "sibo@example.com", phone: "858-394-3045", active: false)
	  	  	@jun = FactoryGirl.create(:customer, first_name: "Jun", last_name: "Song", email: "jun@example.com", phone: "858-956-2495", active: true)
	  	  	@peter = FactoryGirl.create(:customer, first_name: "Peter", last_name: "Bugbee", email: "peter@example.com", phone: "610-495-2956", active: false)
	  	  	@joshua = FactoryGirl.create(:customer, first_name: "Joshua", last_name: "Elliott", email: "josh@example.com", phone: "301-204-2069", active: true)
		end

		def destroy_customers
			@joshua.destroy 
			@peter.destroy
			@jun.destroy
			@sibo.destroy
			@russell.destroy
			@daniel.destroy
		end
	end
end