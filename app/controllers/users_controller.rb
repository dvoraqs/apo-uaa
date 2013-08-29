class UsersController < ApplicationController
  # force_ssl
  # possibly re-enable when Openshift supports custom SSL certificates

  def index
    @page = @header = 'Users List'
    @users = User.where('status IS NOT NULL').all
    @needs_verification = User.where('status IS NULL').all

    if current_user == nil || current_user.access_level < 3
      flash[:alert] = 'Not authorized to view that page'
      redirect_to root_path
    end
  end

  def new
    @page = @header = 'New User'
    @user = User.new
  end

  def edit
    # return an HTML form for editing a user
    @user = User.find(params[:id])
    @page = 'Edit ' + @user.name
    @header = @user.name
  end

  def show
    # display a specific user
    @user = User.find(params[:id])
    @page = @header = @user.name
    @nav = 'User'

    @needs_verification = User.where('status IS NULL').all.length

    # if (current_user == nil or current_user.id != @user.id) and current_user.access_level < 3
    #   flash[:alert] = 'Not authorized to view that page'
    #   redirect_to root_path
    # end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => 'You are now registered. Welcome ' + @user.name + '!'
    else
      flash.now[:alert] = 'There was a problem creating the user'
      @page = @header = 'New User'
      render 'new'
    end
  end

  def update
    user = User.find(params[:id])

    if user.update_attributes(params[:user])
      flash[:notice] = 'Successfully updated user ' + user.name
    else
      flash[:alert] = 'There was a problem changing user ' + user.name
    end

    redirect_to user_path(user)
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "Successfully deleted user " + user.name
    else
      flash[:alert] = "There was a problem deleting user " + user.name
    end
    redirect_to users_path
  end
end