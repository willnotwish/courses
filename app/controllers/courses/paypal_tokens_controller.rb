require_dependency "courses/application_controller"

module Courses

  class PaypalTokensController < ApplicationController

  	before_action :set_course_membership

	  def new
	  	@paypal_token = PaypalTokenOperation.new token_params
	  	respond_with @paypal_token
    end

    def create
	  	@paypal_token = PaypalTokenOperation.new token_params
	  	@paypal_token.save
	  	respond_with @paypal_token, location: @paypal_token.express_checkout_url
    end

  	def set_course_membership
  		@course_membership = CourseMembership.find params[:course_membership_id]
  	end

  private

  	def token_params
  		params.fetch( :paypal_token, {} )
  		      .permit()
  		      .merge( course_membership: @course_membership, 
  		      	      ip_address:        request.remote_ip, 
  		      	      user:              current_user,
  		      	      return_url:        url_for([:new, @course_membership, :paypal_payment]),
  		      	      cancel_return_url: url_for(@course_membership) )
  	end
  end
end
