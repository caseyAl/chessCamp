class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.role? :admin
         can :manage, :all
       elsif user.role? :Instructor
        can :read, :curriculums
        can :read, :locations
        can :read, :camps

        # they can update their own profile
        can :update, User do |u|  
            u.id == user.id
          end

        can :index, Student do |this_student|
          instruct = Instructor.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
          my_students = instruct.camps.students.map(&:id)
          my_students.include? this_student.id 
        end

        can :show, Student do |this_student|
          instruct = User.all.map{|e| e}.select{|e| e.id == user.id}[0]
          my_students = instruct.camps.students.map(&:id)
          my_students.include? this_student.id 
        end

        can :read, Family do |this_family|
          curInstruct = Instructor.all.map{|e| e}.select{|e| e.user.id == user.id}[0]
          my_students = curInstruct.camps.students
          my_fams = []
          my_students.each do |stud|
            my_fams += stud.family unless my_fams.include? stud.family
          end
          my_families = my_fams.map(&:id)
          my_families.include? this_family.id 
        end

        elsif user.role? :Parent
          can :show, User do |u|  
            u.id == user.id
          end

          can :read, :camps 
          can :read, :curriculums

          can :manage, Student do |this_student|
            curFam = Family.map{|e| e}.select{|e| e.user.id == user.id}[0]
            my_students = curFam.students.map(&:id)
            my_students.include? this_student.id 
          end

        else #guest users
          can :read, :camps
          can :read, :curriculums
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
