class HomeController < ApplicationController
  #authorize_resource
  def index
  	if(logged_in? && current_user.role?(:instructor))
  		@cur_Instructor = Instructor.all.select{|e| e.user_id == current_user.id }[0] 
  		@camps = @cur_Instructor.camps.all.map{|e| e}
  		@students = []
  		for c in @camps 
  			@students += c.students
  		end
      @students.paginate(:page => params[:page], :per_page => 10)
    else
      @upcomingCamps = Camp.upcoming.alphabetical.paginate(:page => params[:upcomingCamps]).per_page(10)
      @currics = Curriculum.active.alphabetical.paginate(:page => params[:currics]).per_page(10)
    end


  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end