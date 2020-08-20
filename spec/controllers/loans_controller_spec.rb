# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10_000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#payments' do
    let(:loan) { FactoryBot.create(:loan, funded_amount: 500) }
    let!(:payments) { FactoryBot.create_list(:payment, 5, loan_id: loan.id, amount: 5) }

    it 'responds with a loans payments' do
      get :payments, params: { loan_id: loan.id }
      expect(response.body).to eq payments.to_json
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10_000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
