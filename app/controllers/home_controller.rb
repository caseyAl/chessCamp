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
    elsif (logged_in? && current_user.role?(:parent))
      @fam = Family.for_user(current_user.id).to_a[0]
      @upcomingCamps = Camp.upcoming.alphabetical.paginate(:page => params[:upcomingCamps]).per_page(10)
      @currics = Curriculum.active.alphabetical.paginate(:page => params[:currics]).per_page(10)
      unless @fam == nil
        @kids = Student.for_fam(@fam.id).alphabetical.paginate(:page => params[:page]).per_page(12)
      end
    elsif (logged_in? && current_user.role?(:admin))
      @revenue = Registration.all.to_a.map{|e| e.camp.cost}.inject(0){|sum,x| sum + x }
      @regs = Registration.all.to_a.length
      @activeCamps = Camp.all.active.to_a.length
      @activeStudents = Student.all.active.to_a.length
      @instructors = Instructor.all.active.to_a
      

      
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