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

	def input_cc
	end

	def pay_for_cart
		@total_cost = calculate_total_cart_registration_cost
		@credit_card_number = params[:registration][:credit_card_number]
		@expiration_year = params[:registration][:expiration_year].to_i
		@expiration_month = params[:registration][:expiration_month].to_i
		@credit_card = CreditCard.new(@credit_card_number, @expiration_year, @expiration_month)
		@cartElems = get_array_of_ids_for_generating_registrations
		if @credit_card == nil || @credit_card_number == nil || @credit_card.valid? == false || @expiration_year == nil || @expiration_month == nil 
			flash[:notice] = "Invalid credit card info"
			redirect_to input_cc_path
		else
			@cartElems.each do |e| 
				camp = Camp.find(e[0].to_i)
				student = Student.find(e[1].to_i)
				@reg = Registration.new(camp: camp, student: student, credit_card_number: @credit_card_number, expiration_month: @expiration_month, expiration_year: @expiration_year)
				if @reg.valid? 
					flash[:notice] = "Student was registered!"
					@reg.save!
					@reg.pay 
					redirect_to home_path
				else
					flash[:notice] = "student cannot be registered"
					redirect_to input_cc_path
				end
		end
	end
		
	end


end  