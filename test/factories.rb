FactoryGirl.define do
	factory :address do
		association :customer
		is_billing true
		recipient "Daniel Song"
		street_1 "5000 Forbes Ave"
		street_2 "SMC 5365"
		city "Pittsburgh"
		state "PA"
		zip "15213"
		active true
	end

	factory :customer do
		first_name "Daniel"
		last_name "Song"
		email "dtsong@andrew.cmu.edu"
		phone "394-204-4596"
		active true
	end

	factory :order do 
		date "2015-03-03"
		association :customer
		association :address
		grand_total 22.50; 6.27
		payment_receipt 
	end 
end