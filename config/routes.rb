Rails.application.routes.draw do
  defaults format: :json do
    resources :payments, only: [:show, :create]
    resources :loans
  end
end
