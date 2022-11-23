class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :layout => nil
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order(created_at: :desc)
    # @new_question = @user.questions.build
    @new_question = Question.new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  private
  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
