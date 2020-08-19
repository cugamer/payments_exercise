# frozen_string_literal: true

class Loan < ActiveRecord::Base
  has_many :payments

  attribute :outstanding_balance

  def outstanding_balance
    (funded_amount.to_i - payments.sum(:amount)).to_f.to_s
  end
end
