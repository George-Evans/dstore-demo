class PaymentsController < ApplicationController

	def create
		#Load current Product
		@product = Product.find(params[:product_id])

		#Load current User
		@user = current_user

		#Get payment token which is created when Checkout form is submitted
		token = params[:stripeToken]

		# Create Charge on Stripe server
		begin
			charge = Stripe::Charge.create(
				amount: @product.price,
				currency: "GBP",
				source: token,
				description: params[:stripeEmail]
			)

		if charge.paid
			Order.create(product_id: @product.id, user_id: @user.id, total: @product.price)
		end

		rescue Stripe::CardError => e
			# Card Declined
			body = e.json_body
			err = body[error]
			flash[:error] = "There was an error processing your payment: #{err[:message]}"
		end

		redirect_to product_path(@product), notice: 'Thank you for your order'
	end

end
