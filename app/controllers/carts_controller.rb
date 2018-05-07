class CartsController < ApplicationController
	include AppHelpers::Cart 
	def index
		@total_cost = calculate_total_cart_registration_cost
	end

	def add_to_cart
		camp_id = params[:registration][:camp_id]
		student_id = params[:registration][:student_id]
		add_registration_to_cart(camp_id, student_id)
		@camp = Camp.find(camp_id)
		flash[:notice] = "Added camp to the cart"
		redirect_to @camp
	end

	def remove_from_cart
		camp_id = params[:camp_id]
		student_id = params[:student_id]
		remove_registration_from_cart(camp_id, student_id)
		flash[:notice] = "Removed camp from cart"
		redirect_to carts_path

	end


end 