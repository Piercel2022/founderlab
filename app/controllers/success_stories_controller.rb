class SuccessStoriesController < ApplicationController
  before_action :set_success_story, only: [:show, :edit, :update, :destroy]

  def index
    @success_stories = SuccessStory.recent
  end

  def show
  end

  def new
    @success_story = SuccessStory.new
  end

  def create
    @success_story = SuccessStory.new(success_story_params)
    
    if @success_story.save
      redirect_to @success_story, notice: 'Success story was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @success_story.update(success_story_params)
      redirect_to @success_story, notice: 'Success story was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @success_story.destroy
    redirect_to success_stories_url, notice: 'Success story was successfully deleted.'
  end

  private

  def set_success_story
    @success_story = SuccessStory.find(params[:id])
  end

  def success_story_params
    params.require(:success_story).permit(
      :title,
      :founder_name,
      :founder_avatar,
      :company_name,
      :industry,
      :summary,
      :funding_raised,
      :team_size,
      :image_url
    )
  end
end
