class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
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

  private
  def load_user
    @user ||= User.find params[:id]
  end
end
