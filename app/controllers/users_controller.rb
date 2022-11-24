class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :hello, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    if current_user.present?
      redirect_to root_url, alert: 'You already logged'
    else
    @user = User.new
    render :layout => nil
    end
  end
  def create
    redirect_to root_url, alert: 'You already logged' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      redirect_to log_in_path, notice: 'User was successfully created'
    else
      render 'new', :layout => nil
    end
  end

  def edit
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
  end

  def upload
    uploaded_file = params[:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end

  def hello
    @questions = @user.questions.order(created_at: :desc)
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
                                 :name, :username, :avatar_url)
  end
end
