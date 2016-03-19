class UsersController < ApplicationController
  skip_before_action :authorized?
  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @user == current_user
      render :edit
    else
      flash[:notice] = 'You do not have access to edit this profile.'
      redirect_to @user
    end
  end

  def update
    @user.update(user_params) ? redirect_to @user : render :edit
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :city, :state, :country,
      :birthdate, :bio, :password, :password_confirmation
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
