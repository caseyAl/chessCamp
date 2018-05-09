class StudentsController < ApplicationController 
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  authorize_resource
  def index
  	@students = Student.all.alphabetical.paginate(:page => params[:page]).per_page(12)
  end

  def show
  end

  def edit
  end

  def new
    @student = Student.new
    @fam = Family.all.select{|e| e.user_id == current_user.id}[0]
  end

  def create
    @fam = Family.all.select{|e| e.user_id == current_user.id}[0]
  	@student = Student.new(student_params)
  	if @student.save
  		redirect_to student_path(@student), notice: "#{@student.first_name} #{@student.last_name} was added to the system"
  	else
  		render action: 'new'
  	end
  end

  def update
    @fam = Family.all.select{|e| e.user_id == current_user.id}[0]
  	if @student.update(student_params)
  		redirect_to student_path(@student), notice: "#{@student.first_name} #{@student.last_name} was revised in the system"
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@student.destroy
  	redirect_to students_url, notice: "#{@student.first_name}, #{@student.last_name} was deleted from the system"
  end

  private
  	def set_student
  		@student = Student.find(params[:id])
  	end

  	def student_params
  		params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
	end
end
