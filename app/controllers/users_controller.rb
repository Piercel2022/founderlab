class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update]
  before_action :check_rate_limit, only: [:update]

  def index
    @users = policy_scope(User).includes(:projects, :mentorships).order(created_at: :desc).page(params[:page])
  end

  def show
    @recent_activities = @user.activities.latest
    @completed_projects = @user.projects.completed
    @ongoing_mentorships = @user.mentorships.active
  end

  def update
    User.transaction do
      if @user.update(user_params)
        @user.update_profile_completion_status
        notify_profile_update
        redirect_to @user, notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end
  end

  private

  def notify_profile_update
    UserMailer.profile_updated(@user).deliver_later
    SlackNotifier.notify("User #{@user.name} updated their profile") if @user.profile_completion_status_changed?
  end

  def check_rate_limit
    key = "user_updates:#{current_user.id}"
    unless Rails.cache.read(key).to_i < 5
      redirect_to edit_user_path(@user), alert: 'Too many update attempts. Please try again later.'
      return
    end
    Rails.cache.write(key, Rails.cache.read(key).to_i + 1, expires_in: 1.hour)
  end
end
