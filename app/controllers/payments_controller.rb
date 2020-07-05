class PaymentsController < ApplicationController
  def show
  end

  def create
    payment = Payment.new(payment_params)

    if payment.save!
      render json: {}, status: :created
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def payment_params
    params.permit(:amount, :loan_id)
  end
end
