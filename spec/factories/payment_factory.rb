# frozen_string_literal: true

FactoryBot.define do
  loan = FactoryBot.create(:loan)

  factory :payment do
    amount { 5 }
    loan_id { loan.id }
  end
end
