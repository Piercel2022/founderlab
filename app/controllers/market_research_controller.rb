class MarketResearchController < ApplicationController
  class MarketResearchesController < ApplicationController
    before_action :set_market_research, only: [:show, :update, :destroy]
    before_action :authenticate_user!
  
    def index
      @market_researches = MarketResearch.where(project_id: params[:project_id])
      render json: @market_researches
    end
  
    def show
      render json: @market_research
    end
  
    def create
      @market_research = MarketResearch.new(market_research_params)
      if @market_research.save
        render json: @market_research, status: :created
      else
        render json: @market_research.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @market_research.update(market_research_params)
        render json: @market_research
      else
        render json: @market_research.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @market_research.destroy
      head :no_content
    end
  
    private
  
    def set_market_research
      @market_research = MarketResearch.find(params[:id])
    end
  
    def market_research_params
      params.require(:market_research).permit(:project_id, :market_size, :competitors, :target_audience, :pain_points, :opportunities)
    end
end
