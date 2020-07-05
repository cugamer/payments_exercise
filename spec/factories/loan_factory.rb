# frozen_string_literal: true

FactoryBot.define do
  factory :loan, class: Loan do
    funded_amount { 10_000 }
  end
end
