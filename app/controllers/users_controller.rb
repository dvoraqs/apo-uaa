class UsersController < ApplicationController
  force_ssl

  def index
    @page = @header = 'Users List'

    if current_user == nil || current_user.access_level < 2
      flash[:alert] = 'Not authorized to view that page'
      redirect_to '/'
    end

    @users = User.all
  end

  def new
    @page = @header = 'New User'
    @user = User.new
  end

  def show
    # display a specific user
    @user = User.find(params[:id])
    @page = @header = @user.name

    if @user.access_level >= 2
      @needs_verification = User.where('user_id IS NULL').all
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to '/', :notice => "Signed Up!"
    else
      flash[:alert] = 'The user could not be created'
      redirect_to new_user_path
    end
  end

  def update
    @user = User.find(params[:verify_id])
    if @user.update_attributes({:status => params[:status], :user_id => params[:id]})
      flash[:notice] = @user.name + " was successfully verified as a " + @user.status
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'There was a problem changing the verification on the user'
      redirect_to user_path(current_user)
    end
  end
end