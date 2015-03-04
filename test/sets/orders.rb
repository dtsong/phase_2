module Contexts
	module Orders
	# Context for customers
		def create_orders
			@daniel_1 = FactoryGirl.create(:order, customer: @daniel, address: @cmu_dtsong)
			@daniel_2 = FactoryGirl.create(:order, date: "2015-03-04", customer: @daniel, address: @cmu_dtsong)
			@russell_1 = FactoryGirl.create(:order, date: "2015-03-05", customer: @russell, address: @cmu_russelll)
			@josh_1 = FactoryGirl.create(:order, date: "2015-03-07", customer: @joshua, address: @usna)
			@jun_1 = FactoryGirl.create(:order, date: "2015-03-09", customer: @jun, address: @sd)

			# Orders for INACTIVE customers
			#@sibo_1 = FactoryGirl.create(:order, date: "2015-03-06", customer: @sibo, address: @uchicago)
			#@peter_1 = FactoryGirl.create(:order, date:"2015-03-08", customer: @peter, address: @liferay)
		end

		def destroy_orders
			@daniel_1.destroy
			@daniel_2.destroy
			@russell_1.destroy
			@josh_1.destroy
			@jun_1.destroy
		end
	end
end