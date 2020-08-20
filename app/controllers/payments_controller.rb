# frozen_string_literal: true

class PaymentsController < ApplicationController
  def show
    render json: Payment.find(params[:id]), status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  def create
    Payment.create(payment_params)
    render json: {}, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def payment_params
    params.permit(:amount, :loan_id)
  end
end
