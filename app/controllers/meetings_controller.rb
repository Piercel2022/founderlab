class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = if current_user.mentor?
                  current_user.mentor_meetings
                else
                  current_user.startup_meetings
                end
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.organizer = current_user

    if @meeting.save
      MeetingNotifier.schedule(@meeting).deliver_later
      redirect_to @meeting, notice: 'Meeting scheduled successfully.'
    else
      render :new
    end
  end

  def update
    if @meeting.update(meeting_params)
      MeetingNotifier.update(@meeting).deliver_later
      redirect_to @meeting, notice: 'Meeting updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :description, :start_time, :end_time, :meeting_type, :location, :virtual_meeting_link, participant_ids: [])
  end
end
