Courses::Engine.routes.draw do
  
  resources :courses, only: [:index, :show] do
	  resources :enrolments, only: [:new, :create]
  end

  resources :course_memberships, path: 'course-memberships', only: [:index, :show] do
  	resource :confirmation, only: [:new, :create]
    resource :paypal_token, only: [:new, :create], path: 'paypal-token'
  	resource :paypal_payment, only: [:new, :create, :show], path: 'paypal-payment'
  end

  namespace :admin do
	  resources :courses
	  # resources :course_memberships, path: 'course-memberships'
	  root to: 'home#index'
  end

  root to: 'courses#index'
end
