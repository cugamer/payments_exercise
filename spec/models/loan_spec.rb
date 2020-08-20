# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should have_many(:payments) }

  describe 'when querying for outstanding balance' do
    describe 'for a single loan' do
      let(:funded_amount) { 50 }
      let(:loan) { FactoryBot.create(:loan, funded_amount: funded_amount) }
  
      it 'should return the oustanding balance' do
        loan.payments.create(amount: funded_amount / 2)
        expect(loan.outstanding_balance).to eq funded_amount / 2
        expect(Loan.loans_with_balance(loan.id).outstanding_balance).to eq funded_amount / 2
      end
    end

    describe 'for multiple loans' do
      let(:funded_amount) { 50 }
      let(:loans) { FactoryBot.create_list(:loan, 5, funded_amount: funded_amount) }
      
      it 'should return the oustanding balance' do
        loans.first.payments.create(amount: funded_amount / 2)
        expect(loans.first.outstanding_balance).to eq funded_amount / 2
        expect(Loan.loans_with_balance.first.outstanding_balance).to eq funded_amount / 2
        expect(Loan.loans_with_balance.last.outstanding_balance).to eq funded_amount
      end
    end
  end
end
