# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'GET /show' do
    describe 'when payment with id exists' do
      let(:payment) { FactoryBot.create(:payment) }

      it 'returns http success' do
        get "/payments/#{payment.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include 'amount' => payment.amount
      end
    end

    describe 'when payment with id does not exist' do
      let(:payment_id) { Payment&.last&.id || 0 }

      it 'returns http bad request' do
        get "/payments/#{payment_id + 1}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    let(:loan) { FactoryBot.create(:loan) }
    let(:headers) { { 'ACCEPT' => 'application/json' } }

    describe 'when payment is not greater than loan balance' do
      let(:payment_params) { { loan_id: loan.id, amount: loan.funded_amount / 2 } }

      it 'returns http created' do
        post '/payments', params: payment_params, headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    describe 'when payment is greater than loan balance' do
      let(:payment_params) { { loan_id: loan.id, amount: loan.funded_amount * 2 } }

      it 'returns http bad request' do
        post '/payments', params: payment_params, headers: headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
