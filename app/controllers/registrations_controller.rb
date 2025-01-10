class RegistrationsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      # Create default startup profile for the user
      @startup = @user.create_startup(
        name: "My Startup",
        stage: "ideation",
        status: "active"
      )
      
      # Send welcome email
      UserMailer.welcome_email(@user).deliver_later
      
      # Auto-login after registration
      session[:user_id] = @user.id
      
      flash[:success] = "Welcome to FounderLab! Your account has been successfully created."
      redirect_to onboarding_path
    else
      flash.now[:error] = "There was a problem with your registration."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :role,
      :terms_accepted
    )
  end

  def redirect_if_authenticated
    if current_user
      flash[:info] = "You are already registered and logged in."
      redirect_to dashboard_path
    end
  end
end