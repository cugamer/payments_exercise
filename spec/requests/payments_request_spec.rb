require 'rails_helper'

RSpec.describe "Payments", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/payments/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:loan){ FactoryBot.create(:loan) } 
    let(:headers) { { "ACCEPT" => "application/json" } }
    
    describe 'when payment is not greater than loan balance' do
      let(:payment_params) { { loan_id: loan.id, amount: loan.funded_amount / 2} }

      it "returns http created" do
          post "/payments", params: payment_params, headers: headers
          expect(response).to have_http_status(:created)
      end
    end
      
    describe 'when payment is greater than loan balance' do
      let(:payment_params) { { loan_id: loan.id, amount: loan.funded_amount * 2} }

      it "returns http bad request" do
        post "/payments", params: payment_params, headers: headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
