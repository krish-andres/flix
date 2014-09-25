class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all    
  end

  def show
  end

  def new
    @user = User.new    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Account Successfully Created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account Successfully Updated!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: "Account Successfully Deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_correct_user
    unless current_user?(@user)
      redirect_to root_url, alert: "Unauthorized Access!"
    end
  end
end
