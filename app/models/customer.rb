class Customer < ActiveRecord::Base
	# creates a callback that will strip non-digits before saving to db
	before_save :reformat_phone

	# Relationships
	# ---------------------------
	has_many :orders
	has_many :addresses

	# Scopes
	# ----------------------------
	# lists customers in alphabetical order
	scope :alphabetical, -> { order('first_name, last_name') }
	# gets all active customers
	scope :active, -> { where(active: true) }
	# gets all inactive customers
	scope :inactive, -> { where(active: false) } 

	# Validations
	# ----------------------------
	validates_presence_of :first_name, :last_name
	# evaluates inputted phone number if it exists
	validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only" 
	# email formatting for inputted email
  	validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  	# a method to get the customer name in last name, first name format
  	def name
  		last_name + ", " + first_name
  	end

  	# a method to get the customer name in first name, last name format
  	def proper_name
  		first_name + " " + last_name
  	end

	# Callback code
	# -----------------------------
	private
     # We need to strip non-digits before saving to db
     def reformat_phone
       phone = self.phone.to_s  # change to string in case input as all numbers 
       phone.gsub!(/[^0-9]/,"") # strip all non-digits
       self.phone = phone       # reset self.phone to new string
     end
end
