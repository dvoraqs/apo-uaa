class UsersController < ApplicationController
  # force_ssl
  # possibly re-enable when Openshift supports custom SSL certificates

  def index
    set_page nil, 'Users List', 'Users List', nil
    @users = User.where('status IS NOT NULL').all
    @needs_verification = User.where('status IS NULL').all

    if current_user == nil || current_user.access_level < 3
      flash[:alert] = 'Not authorized to view that page'
      redirect_to root_path
    end
  end

  def new
    set_page nil, 'New User', 'New User', nil
    @user = User.new
  end

  def edit
    # return an HTML form for editing a user
    @user = User.find(params[:id])
    set_page nil, 'Edit ' + @user.name, @user.name, nil
  end

  def show
    # display a specific user
    @user = User.find(params[:id])
    set_page 'User', @user.name, @user.name, nil

    if @user.access_level >= 3
      @needs_verification = User.where('status IS NULL').all.length
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => 'You are now registered. Welcome ' + @user.name + '!'
    else
      flash.now[:alert] = 'There was a problem creating the user'
      set_page nil, 'New User', 'New User', nil
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