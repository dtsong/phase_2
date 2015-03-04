class Order < ActiveRecord::Base
	# Relationships
	# ---------------------------
	belongs_to :address
	belongs_to :customer

	# Validations
	# ---------------------------
	validates_date :date
	validate :customer_is_active_in_Bread_Express
	validate :address_is_active_in_Bread_Express

	# Scopes
	# ---------------------------
	# arrange orders with most recent at the top
	scope :chronological, -> { order('date DESC') }
	# returns all paid orders and have a payment receipt
	scope :paid, -> { where.not(payment_receipt => nil)}
	# find all orders for a particular customer
	scope :for_customer, -> (customer_id) { where("customer_id = ?", customer_id) }

	# Methods (for custom validations)
	# ---------------------------
	# this method creates a base64 payment string for payment_receipt 
	def pay 
		# using string addition, append order_id, grand_total, and order date to a string for encoding.
		string_to_encode = "order: " + self.order_id.to_s + "; amount_paid: " + 
						   self.grand_total.to_s + "; received: " + self.date.to_s
		return Base64.encode64(string_to_encode)
	end

	def customer_is_active_in_Bread_Express
	    # get an array of all active customers in the PATS system
	    all_customer_ids = Customer.active.all.map{|c| c.id}
	    # add error unless the customer id is in the array of active owners
	    unless all_customer_ids.include?(self.customer_id)
	      errors.add(:customer, "is not an active customer in Bread Express")
	      return false
	    end
	    return true
  	end

	def address_is_active_in_Bread_Express
	    # get an array of all active addresses in the PATS system
	    all_address_ids = Address.active.all.map{|a| a.id}
	    # add error unless the address id is in the array of active addresses
	    unless all_address_ids.include?(self.address_id)
	      errors.add(:address, "is not an active address in Bread Express")
	      return false
	    end
	    return true
  	end
end