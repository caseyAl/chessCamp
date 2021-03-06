class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  #authorize_resource
  #before_action :set_registration, [:show, :edit, :update, :destroy]
  def new 
    @registration = Registration.new
    #@camp = Camp.find(params[:camp_id])
    #@student = Student.find(params[:student_id])
  end
  
  def create
    @registration = Registration.new(registration_params)
    #@registration.credit_card_number = params[:credit_card_number]
    #@registration.expiration_year = params[:expiration_year]
    #@registration.expiration_month = params[:expiration_month]
    #credit_card_number_is_valid
    #expiration_date_is_valid
    #@registration.pay
    if @registration.save
      flash[:notice] = "Successfully registered for camp"
      redirect_to home_path
    else
      render action: 'new'
    end  
  end

  
  def destroy
    camp_id = params[:id]
    student_id = params[:id]
    @registration = Registration.where(student_id: student_id, camp_id: camp_id).first
    unless @registration.nil?
      @registration.destroy
      flash[:notice] = "Successfully destroyed this registration"
    end
  end

  def index
    @registrations = Registration.all.alphabetical.paginate(:page => params[:registrations]).per_page(10)
  end





  private
    def registration_params
      params.require(:registration).permit(:camp_id, :student_id)
    end

    def set_registration
      @registration = Registration.find([:id])
    end

end