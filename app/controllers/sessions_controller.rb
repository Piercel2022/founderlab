class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  before_action :authenticate_user!, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user && @user.authenticate(params[:password])
      # Set session
      session[:user_id] = @user.id
      
      # Update last login timestamp
      @user.update_column(:last_login_at, Time.current)
      
      # Set remember token if "Remember me" was checked
      if params[:remember_me] == '1'
        remember_token = SecureRandom.urlsafe_base64
        @user.update_column(:remember_token, remember_token)
        cookies.permanent.encrypted[:remember_token] = remember_token
      end

      flash[:success] = "Welcome back, #{@user.first_name}!"
      redirect_back_or_to dashboard_path
    else
      flash.now[:error] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Clear session
    session.delete(:user_id)
    
    # Clear remember token if it exists
    if cookies.encrypted[:remember_token]
      current_user&.update_column(:remember_token, nil)
      cookies.delete(:remember_token)
    end

    flash[:success] = "You have been successfully logged out."
    redirect_to root_path, status: :see_other
  end

  private

  def redirect_if_authenticated
    if current_user
      flash[:info] = "You are already logged in."
      redirect_to dashboard_path
    end
  end

  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def authenticate_user!
    unless current_user
      session[:return_to] = request.original_url
      flash[:error] = "Please log in to continue."
      redirect_to login_path
    end
  end
end