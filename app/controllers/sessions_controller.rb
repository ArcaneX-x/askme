class SessionsController < ApplicationController
  def new
    render :layout => nil
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user.present?
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'User successfully login'
    else
      flash.now.alert = 'Invalid email or password'
      render 'new', :layout => nil
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'You logged out'
  end
end
