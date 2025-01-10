class MentorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mentor, only: [:show, :edit, :update, :destroy]

  def index
    @mentors = Mentor.includes(:expertise_areas).all
    @mentors = @mentors.where(expertise: params[:expertise]) if params[:expertise].present?
  end

  def show
    @availability = @mentor.availability_slots
    @reviews = @mentor.reviews.includes(:user)
  end

  def request_mentorship
    @mentor = Mentor.find(params[:id])
    @mentorship_request = MentorshipRequest.new(
      mentor: @mentor,
      startup: current_user.startup,
      status: 'pending'
    )
    
    if @mentorship_request.save
      MentorMailer.new_request_notification(@mentorship_request).deliver_later
      redirect_to @mentor, notice: 'Mentorship request sent successfully.'
    else
      redirect_to @mentor, alert: 'Unable to send mentorship request.'
    end
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:id])
  end

  def mentor_params
    params.require(:mentor).permit(:name, :bio, :expertise, :availability, expertise_area_ids: [])
  end
end
