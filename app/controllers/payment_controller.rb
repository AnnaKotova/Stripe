require 'stripe'
class PaymentController < ApplicationController
  def index
  end
  def pay
		Stripe.api_key = "sk_test_RO5eTJ0NUYN7VlUfLCN4J7NR" 
		# Get the credit card details submitted by the form 
		#token = params[:stripeToken]
		token = "tok_102rOB2LCXTHdblILt59A61M"
		# Create the charge on Stripe's servers - this will charge the user's card 
		begin 
			charge = Stripe::Charge.create( 
				:amount => 50*100, # amount in cents, again 
				#:amount => params[:amount]*100,
				:currency => "aud", 
				#:currency => params[:currency], 
				:card => token, 
				#:description => params[:description]
				:description => "payinguser@example.com" 
			) 
			@error_message  = "Success"
			rescue Stripe::CardError => e # The card has been declined
				@error_message  = e.message
			rescue Stripe::InvalidRequestError => e 
				@error_message  = e.message
			#redirect_to(:action => 'index')
			# Invalid parameters were supplied to Stripe's API 
			rescue Stripe::AuthenticationError => e 
				@error_message  = e.message
			# Authentication with Stripe's API failed 
			# (maybe you changed API keys recently) 
			rescue Stripe::APIConnectionError => e 
				@error_message  = e.message
			# Network communication with Stripe failed
			rescue Stripe::StripeError => e
				@error_message  = e.message 
			# Display a very generic error to the user, and maybe send 
			# yourself an email 
			rescue => e 
				@error_message  = e.message
			# Something else happened, completely unrelated to Stripe 
			
		end
	end
end
