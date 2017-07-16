class OrdersController < ApplicationController
	before_action :authenticate_user!

	def index
		@orders = Order.all
	end

	def show
	end

	def create
	end

	def destroy
	end
	
end
