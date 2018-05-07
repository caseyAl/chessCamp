class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  #authorize_resource
  def new
    @registration = Registration.new
    @camp = Camp.find(params[:camp_id])
    @student = Student.find(:student_id)
  end
  
  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      flash[:notice] = "Successfully registered for camp"
      redirect_to camp_path(@camp)
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



  private
    def registration_params
      params.require(:registration).permit(:camp_id, :student_id)
    end

end