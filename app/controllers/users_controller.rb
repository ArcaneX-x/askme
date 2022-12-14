# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: %i[index create specialists new]
  before_action :authorize_user, except: %i[index new create show specialists questions]

  def index
    @users = User.last(5)
    # @top_hashtags = Hashtag.where(id: HashtagQuestion.select(:hashtag_id).group(:hashtag_id).order('COUNT(hashtag_id) desc')).limit(7)
    @top_hashtags = ::Hashtags::Queries::Top.call(count: 7)
  end
  def new
    if current_user.present?
      redirect_to root_url, alert: 'You already logged'
    else
      @user = User.new
      render layout: nil
    end
  end

  def create
    redirect_to root_url, alert: 'You already logged' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User was successfully created'
    else
      render 'new', layout: nil
    end
  end

  def edit; end

  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to root_url, notice: 'User has been deleted'
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Date was successfully updated'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def questions
    @questions = @user.questions.order(created_at: :desc)
  end

  def specialists
    @users = User.all
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar)
  end
end
