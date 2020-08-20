Rails.application.routes.draw do
  defaults format: :json do
    resources :payments, only: [:show, :create]
    resources :loans, only: [:show, :index] do
      get '/payments', to: 'loans#payments', as: 'payments'
    end
  end
end
