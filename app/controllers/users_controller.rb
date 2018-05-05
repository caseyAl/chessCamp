class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :check_login
  authorize_resource

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @users = User.all.paginate(page: params[:page]).per_page(15)
  end

  def new 
    @user = User.new
  end

  def edit
    #@user.role = "assistant" if current_user.role?(:assistant)
  end

  def create
    @user = User.new(user_params)
    #@user.role = "assistant" if current_user.role?(:assistant)
    if @user.save
      flash[:notice] = "Welcome #{@user.proper_name}, One more Step!."
      redirect_to new_family_path
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.proper_name}."
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "Successfully removed #{@user.proper_name} from the PATS system."
    else
      render action: 'show'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password_digest, :role, :email, :phone, :active)
    end

end