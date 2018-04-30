class HomeController < ApplicationController
  def index
  	if(logged_in? && current_user.role?(:instructor))
  		@cur_Instructor = Instructor.all.select{|e| e.user_id == current_user.id }[0] 
  		@camps = @cur_Instructor.camps.all.map{|e| e}
  		@students = []
  		for c in @camps 
  			@students += c.students
  		end


  	end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end