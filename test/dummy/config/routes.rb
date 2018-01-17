Rails.application.routes.draw do
  resources :users
  resources :products
  
  mount Courses::Engine => "/courses"
end
