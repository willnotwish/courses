Courses::Engine.routes.draw do
  
  resources :courses, only: [:index, :show, :new, :create, :destroy] do
	  resources :enrolments, only: [:new, :create]
    resources :updates,    only: [:new, :create]
  end

  resources :course_memberships, path: 'course-memberships', only: [:index, :show] do
  	resource :confirmation, only: [:new, :create]
    resource :paypal_token, only: [:new, :create], path: 'paypal-token'
  	resource :paypal_payment, only: [:new, :create, :show], path: 'paypal-payment'
    resources :deletions, only: [:new, :create], controller: 'membership_deletions'
  end

  # namespace :admin do
	 #  resources :courses do
  #     resources :course_memberships, path: 'course-memberships', only: :index
  #   end
  #   resources :course_memberships, path: 'course-memberships', only: [:index, :show]
  #   resource :dashboard, only: :show, controller: :dashboard

	 #  # root to: 'application#index'
  #   root to: 'dashboard#show'
  # end

  root to: 'dashboard#show'
end
