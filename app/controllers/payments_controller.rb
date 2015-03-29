require 'pry' 

class PaymentsController < ApplicationController

	def new
		# @attendee = (get ID from URL)
		# @event = @attendee.event_id
		# @stripe_key = @event.user_id.stripe_key
	end

	def create
		Stripe.api_key = "sk_test_ZJqIzHaMdB2YUxDVXHYJkjnU"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create a Customer
		# customer = Stripe::Customer.create(
		#   :source => token,
		#   :description => "payinguser@example.com"
		# )

		# Charge the Customer instead of the card
		charge = Stripe::Charge.create(
        :amount => 1000, #amount in cents
        :currency => "cad",
        :card => token,
        :description => "description of payment",
		    :capture => false
		    )
    charge.save

		# Save the customer ID in your database so you can use it later
		save_stripe_customer_id(user, customer.id)

		# Later...
		customer_id = get_stripe_customer_id(user)

		Stripe::Charge.create(
		  :amount   => 1500, # $15.00 this time
		  :currency => "cad",
		  :customer => customer_id
		)
	end



end