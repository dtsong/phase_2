module Contexts
	module Orders
	# Context for customers
		def create_orders
			@daniel_1 = FactoryGirl.create(:order)
			@daniel_2
			@russell_1
			@sibo_1
			@josh_1
			@peter_1
		end

		def destroy_orders

		end
	end
end