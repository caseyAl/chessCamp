class CampInstructorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  authorize_resource
  def new
    @camp_instructor   = CampInstructor.new
    @camp              = Camp.find(params[:camp_id])
    @other_instructors = @camp.instructors
  end
  
  def create
    @camp_instructor = CampInstructor.new(camp_instructor_params)
    if @camp_instructor.save
      flash[:notice] = "Successfully added instructor."
      redirect_to camp_path(@camp_instructor.camp)
    else
      @camp = Camp.find(params[:camp_instructor][:camp_id])
      @other_instructors = @camp.instructors
      render action: 'new', locals: { camp: @camp, other_instructors: @other_instructors }
    end
  end
 
  def destroy
    camp_id = params[:id]
    instructor_id = params[:instructor_id]
    @camp_instructor = CampInstructor.where(camp_id: camp_id, instructor_id: instructor_id).first
    unless @camp_instructor.nil?
      @camp_instructor.destroy
      flash[:notice] = "Successfully removed this instructor."
    end

  end

  private
    def camp_instructor_params
      params.require(:camp_instructor).permit(:camp_id, :instructor_id)
    end

end