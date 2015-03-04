require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Runs ActiveRecord macros
  # Relationship Tests
  # ----------------------------------------
  should have_many(:addresses)
  should have_many(:orders)

  # Validation Tests
  # ----------------------------------------
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  # Validates email
  should allow_value("daniel@daniel.com").for(:email)
  should allow_value("daniel@andrew.cmu.edu").for(:email)
  should allow_value("my_daniel@daniel.org").for(:email)
  should allow_value("daniel123@daniel.gov").for(:email)
  should allow_value("my.daniel@daniel.net").for(:email)
  
  should_not allow_value("daniel").for(:email)
  should_not allow_value("daniel@daniel,com").for(:email)
  should_not allow_value("daniel@daniel.uk").for(:email)
  should_not allow_value("my daniel@daniel.com").for(:email)
  should_not allow_value("daniel@daniel.con").for(:email)

  # Validates phone
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  # ---------------------------------------
  context "Given context" do
  	  # create objects with factories
  	  setup do 
  	  	create_customers
  	  end

  	  # teardown method for removing objects as needed
  	  teardown do 
        destroy_customers
  	  end

  	  # checks each factory to see if objects were made correctly
  	  should "show that all objects were created properly" do
  	  	assert_equal "Daniel", @daniel.first_name
  	  	assert_equal "Russell", @russell.first_name
  	  	assert_equal "Sibo", @sibo.first_name
        assert_equal "Peter", @peter.first_name
        assert_equal "Jun", @jun.first_name
        assert_equal "Joshua", @joshua.first_name
  	  	assert @daniel.active
  	  	assert @russell.active
        assert @joshua.active
        assert @jun.active
  	  	deny @sibo.active
        deny @peter.active
  	  end

  	  # tests the 'alphabetical' scope
  	  should "show the six customers in alphabetical order" do
  	  	assert_equal ["Daniel", "Joshua", "Jun", "Peter", "Russell", "Sibo"], Customer.alphabetical.map{|o| o.first_name}
  	  end

  	  # tests the 'active' scope
  	  should "show that there are four active customers" do
  	  	assert_equal 4, Customer.active.size
  	  	assert_equal ["Daniel", "Russell", "Jun", "Joshua"], Customer.active.map { |o| o.first_name }
  	  end

  	  # tests the 'inactive' scope
  	  should "show that there are two inactive customers" do
  	  	assert_equal 2, Customer.inactive.size
  	  	assert_equal ["Sibo", "Peter"], Customer.inactive.map { |o| o.first_name }
  	  end

  	  # tests the 'name' method
  	  should "show that the name method works properly" do
  	  	assert_equal "Song, Daniel", @daniel.name
  	  	assert_equal "Lee, Russell", @russell.name
  	  	assert_equal "Cai, Sibo", @sibo.name
  	  end

  	  # tests the 'proper_name' method
  	  should "show that the proper_name method works properly" do
  	  	assert_equal "Daniel Song", @daniel.proper_name
  	  	assert_equal "Russell Lee", @russell.proper_name
  	  	assert_equal "Sibo Cai", @sibo.proper_name
  	  end

  	  # tests the 'reformat_phone' callback is working
  	  should "show that Russell's phone is stripped of non-digits" do
  	  	assert_equal "4123043495", @russell.phone
  	  end
  end
end
