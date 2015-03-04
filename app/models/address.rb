class Address < ActiveRecord::Base
	# Relationships
	# ---------------------------
	has_many :orders
	belongs_to :customer

	# Scopes
	# ----------------------------
	# gets all active addresses
	scope :active, -> { where(active: true) }
	# gets all inactive addresses
	scope :inactive, -> { where(active: false) } 
	# orders results by recipient name
	scope :by_recipient, -> { order('recipient ASC') }
	# orders results by customer name
	scope :by_customer, -> { joins(:customer).order('customers.last_name, customers.first_name') }
	# gets all addresses that are just shipping addresses
	scope :shipping, -> { where(is_billing: false) }
	# gets all addresses that are also billing addresses
	scope :billing, -> { where(is_billing: true) }

	# STATES_LIST contains state related information for the state validation
	STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

	# Validations
	# ----------------------------
	validates_presence_of :recipient, :street_1, :zip
	validates_inclusion_of :state, in: STATES_LIST.map {|key, value| value}, message: "is not an option", allow_blank: true
	validate :check_for_duplicate_addresses, on: :create


	# Private methods for custom validations
	# ----------------------------

	def check_for_duplicate_addresses
 		# add error if a newly created address has the same recipient and zip code as a previously made record
 		if !Address.where(recipient: self.recipient, zip: self.zip).empty?
 			errors.add(:address, "already exists in the Bread Express")
 		end
	end
end
