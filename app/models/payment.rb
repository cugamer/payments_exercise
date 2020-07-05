class Payment < ActiveRecord::Base
	belongs_to :loan

	validates :date, :amount, presence: true

	before_validation do
		self.date = Date.new
	end
	
	before_save do
		balance = loan.funded_amount.to_i - loan.payments.sum(amount)
		raise ArgumentError, "Payment amount is greater than balance #{balance}" if balance - amount < 0
	end
end
