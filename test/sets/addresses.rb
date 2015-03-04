module Contexts
	module Addresses
	# Context for addresses
		def create_addresses
			@cmu_dtsong = FactoryGirl.create(:address, customer: @daniel)
			@cmu_russelll = FactoryGirl.create(:address, customer: @russell, recipient: "Russell Lee", street_2: "SMC 7196")
			@sd = FactoryGirl.create(:address, customer: @jun, recipient: "Jun Song", street_1: "12219 Fairway Pointe Row", street_2: nil, city: "San Diego", state: "CA", zip: "92128")
			@liferay = FactoryGirl.create(:address, customer: @peter, is_billing: false, recipient: "Peter Bugbee", street_1: "1400 Montefino Ave", street_2: nil, city: "Diamond Bar", state: "CA", zip: "91765", active: false)
			@usna = FactoryGirl.create(:address, customer: @joshua, is_billing: false, recipient: "Joshua Elliott", street_1: "121 Blake Ave", city: "Annapolis", state: "MD", zip: "21402", active: false)
			@uchicago = FactoryGirl.create(:address, customer: @sibo, is_billing: false, recipient: "Sibo Cai", street_1: "5801 S Ellis Ave", city: "Chicago", state: "IL", zip: "60637", active: false)
		end

		def destroy_addresses
			@uchicago.destroy 
			@usna.destroy
			@liferay.destroy
			@sd.destroy
			@cmu_russelll.destroy
			@cmu_dtsong.destroy
		end
	end
end