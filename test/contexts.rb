# require needed files
require './test/sets/addresses'
require './test/sets/customers'
require './test/sets/orders'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Addresses
  include Contexts::Customers
  include Contexts::Orders
end