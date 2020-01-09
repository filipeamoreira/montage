Rails.application.routes.draw do
  get '/', to: 'image_montages#index'
  resources :image_montages do
    collection do
      post :import
      get :export
    end
  end
end
