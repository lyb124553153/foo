Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  post '/links' => 'links#create'
  delete 'links/*code', to: 'links#expire', param: :code
  get 'links/*code', to: 'links#detail', param: :code
  get '/s/:code', to: 'links#show', param: :code, as: :shortener
end
