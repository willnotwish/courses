require_dependency "courses/application_controller"

module Courses
  class PaypalPaymentsController < ApplicationController

  	before_action :set_course_membership, except: [:index]

    def index
    	raise 'Not yet implemented'
    end

    def new
    	@payment = PaypalPaymentOperation.new operation_params
    	respond_with @payment
    end

    def create
    	@payment = PaypalPaymentOperation.new operation_params
    	@payment.save
    	respond_with @payment, location: @course_membership
    end

    def show
    	@payment = @course_membership.payment
    	respond_with @payment
    end

  private

  	def operation_params
  		params.fetch( :paypal_payment_operation, {} )
  		      .permit( :paypal_token, :paypal_payer_id )
  		      .merge( course_membership: @course_membership, user: current_user, ip_address: request.remote_ip )
  		      .tap { |permitted| permitted.merge!( paypal_token: params[:token], paypal_payer_id: params[:PayerID] ) if params[:token].present? && params[:PayerID].present? }
  	end

  	def set_course_membership
  		@course_membership = CourseMembership.find params[:course_membership_id]
  	end
  end
end



  	# @payment = @course_membership.build_payment payment_params
  	# unless @payment[:token].present? && @payment[:payer_id].present?
  	# 	redirect_to @payment.express_checkout_url and return
  	# end

  	# def payment_params
  	# 	amount = @course_membership.course.product.price
  	# 	item = { name: @course_membership.course.name, description: 'Membership of Spa Striders course', quantity: 1, amount: amount }

  	# 	return_url = new_course_membership_payment_url( @course_membership )
  	# 	cancel_return_url = course_membership_url( @course_membership )

  	# 	params.fetch( :payment, { amount: amount, items: [item] } )
  	# 		.permit( :amount, :token, :payer_id, items: [:name, :description, :quantity, :amount] )
  	# 		.merge( currency: 'GBP', ip_address: request.remote_ip, return_url: return_url, cancel_return_url: cancel_return_url )
  	# 		.tap { |permitted| permitted.merge!( token: params[:token], payer_id: params[:PayerID] ) if params[:token].present? && params[:PayerID].present? }
  			
  	# end


    	# @payment = @course_membership.create_payment payment_params
    	# @course_membership.update payment: @payment if @payment.persisted?
