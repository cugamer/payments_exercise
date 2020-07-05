# frozen_string_literal: true

class Loan < ActiveRecord::Base
  has_many :payments
end
