class Ability
  include CanCan::Ability

  def initialize(user) 
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.role? :admin
         can :manage, :all

       elsif user.role? :instructor
        can :read, Curriculum
        can :show, Curriculum
        can :read, Location
        can :show, Location 
        can :read, Camp 
        can :show, Camp  

        can :update, Instructor do |i|
          instruct = User.all.map{|e| e}.select{|e| e.id == user.id}[0]
          i.id == instruct.id 
        end

        # they can update their own profile
        can :update, User do |u|  
            u.id == user.id
          end

        can :read, Student do |this_student|
          instruct = Instructor.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
          my_camps = instruct.camps
          my_students= []
          my_camps.each do |camp| 
              my_students += camp.students  
            end
          my_students.include? this_student.id 
        end

        can :read, Family do |this_family|
          curInstruct = Instructor.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
          my_camps = curInstruct.camps
          my_students= []
          my_camps.each do |camp| 
              my_students += camp.students  
            end
          my_fams = []
          my_students.each do |stud|
            my_fams += [stud.family] unless my_fams.include? stud.family
          end
          my_families = my_fams.map(&:id)
          my_families.include? this_family.id 
        end

        elsif user.role? :parent
          can :read, Curriculum
          can :show, Curriculum
          can :read, Camp 
          can :show, Camp
          can :create, Family
          can :create, Registration
          can :create, Student
          can :update, User do |u|
            u.id == user.id 
          end

          can :students, Camp


          can :show, User do |u|  
            u.id == user.id
          end

          can :update, Student do |this_student|
            curFam = Family.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
            my_students = curFam.students.map(&:id)
            my_students.include? this_student.id 
          end

          can :show, Student do |this_student|
            curFam = Family.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
            my_students = curFam.students.map(&:id)
            my_students.include? this_student.id 
          end


        else #guest users
          can :read, Camp
          can :read, Curriculum
          can :show, Camp 
          can :show, Curriculum
          can :create, User
          can :create, Family
         
       end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
