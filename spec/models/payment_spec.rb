# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should validate_presence_of(:amount) }

  it { should belong_to(:loan) }

  describe 'when creating payment' do
    let(:loan) { FactoryBot.create(:loan) }
    let(:balance) { loan.funded_amount }

    it 'should return success when payment is less than loan balance' do
      Payment.create!(amount: balance / 2, loan_id: loan.id)
      expect(Payment.count).to eq 1
    end

    it 'should raise error when payment is greater than loan balance' do
      Payment.create!(amount: balance / 2, loan_id: loan.id)
      Payment.create!(amount: balance / 2, loan_id: loan.id)
      expect { Payment.create!(amount: balance / 2, loan_id: loan.id) }.to raise_exception
    end
  end
end
