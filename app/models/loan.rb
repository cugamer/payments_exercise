# frozen_string_literal: true

class Loan < ActiveRecord::Base
  has_many :payments

  def self.loans_with_balance(loan_id = nil)
    attribute :outstanding_balance

    if loan_id
      loans = Loan.includes(:payments).find(loan_id)
      loans.assign_attributes(outstanding_balance: loans.outstanding_balance)
    else
      loans = Loan.includes(:payments)
      loans.each { |loan| loan.assign_attributes(outstanding_balance: loan.outstanding_balance) }
    end

    return loans
  end

  def outstanding_balance
    payments_sum = self.payments.reduce(0) { |sum, h| sum += h['amount'] }
    self.funded_amount - payments_sum
  end
end
