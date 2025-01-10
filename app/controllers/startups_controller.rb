class StartupsController < ApplicationController
  before_action :set_startup, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @startups = Startup.includes(:user).all
  end

  def show
    @metrics = @startup.metrics.recent
    @team_members = @startup.team_members
    @documents = @startup.documents
  end

  def new
    @startup = current_user.startups.build
  end

  def create
    @startup = current_user.startups.build(startup_params)
    if @startup.save
      redirect_to @startup, notice: 'Startup was successfully created.'
    else
      render :new
    end
  end

  def update
    if @startup.update(startup_params)
      redirect_to @startup, notice: 'Startup was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_startup
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:name, :description, :industry, :stage, :funding_status, :website, :pitch_deck)
  end
end
