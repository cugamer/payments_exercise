# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should have_many(:payments) }

  describe 'when querying a loan' do
    let(:funded_amount) { 50 }
    let(:loan) { FactoryBot.create(:loan, funded_amount: funded_amount) }

    it 'should return the oustanding balance' do
      loan.payments.create(amount: funded_amount / 2)
      expect(loan.reload.outstanding_balance).to eq (funded_amount / 2).to_f.to_s
    end
  end
end
