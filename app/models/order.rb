class Order < ActiveRecord::Base
	# Relationships
	# ---------------------------
	belongs_to :address
	belongs_to :customer

	# Validations
	# ---------------------------
	validates_date :date
	# ensures that the grand_total input has 2 decimal places or less
	validates :grand_total, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
	validate :customer_is_active_in_Bread_Express
	validate :address_is_active_in_Bread_Express

	# Scopes
	# ---------------------------
	# arrange orders with most recent at the top
	scope :chronological, -> { order('date ASC') }
	# returns all paid orders and have a payment receipt
	scope :paid, -> { where.not(:payment_receipt => nil)}
	# find all orders for a particular customer
	scope :for_customer, -> (customer_id) { where("customer_id = ?", customer_id) }

	# Methods (for custom validations)
	# ---------------------------
	# this method creates a base64 payment string for payment_receipt 
	def pay 
		# get an array of PAID order ids
		all_paid_orders_ids = Order.paid.all.map { |o| o.id  }
		# if order has not yet been paid (its id is not in the array), generate the payment_receipt
		if !all_paid_orders_ids.include?(self.id)
			# using string addition, append order_id, grand_total, and order date to a string for encoding.
			string_to_encode = "order: " + self.id.to_s + "; amount_paid: " + self.grand_total.to_s + "; received: " + self.date.to_s
			self.payment_receipt = Base64.encode64(string_to_encode)
			save!
		end
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