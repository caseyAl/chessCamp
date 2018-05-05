class FamiliesController < ApplicationController 
	before_action :set_family, only: [:show, :edit, :update, :destroy]
	authorize_resource
	def index
		@familys = Family.all.alphabetical.paginate(:page => params[:page]).per_page(12)
	end

	def show
		@students = @family.students.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def edit
	end

	def new
		@family = Family.new
	end

	def create
		@family = Family.new(family_params)
		if @family.save
			redirect_to family_path(@family), notice: "The #{@family.family_name}s were added to the system"
		else
			render action: 'new'
		end
	end

	def update
		if @family.update(family_params)
			redirect_to family_path(@family), notice:  "The #{@family.family_name}s were updated in the system"
		else
			render action: 'edit'
		end
	end

	def destroy
		@family.destroy
		redirect_to familys_url, notice: "The #{@family.family_name}s were deleted from the system"
	end

	private
		def set_family
			@family = Family.find(params[:id])
		end

		def family_params
			params.require(:family).permit(:family_name, :parent_first_name, :user_id, :active)
			
		end
end