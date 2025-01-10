class MetricsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_startup
  before_action :set_metric, only: [:show, :edit, :update, :destroy]

  def index
    @metrics = @startup.metrics.order(date: :desc)
    @revenue_data = @metrics.pluck(:date, :revenue)
    @user_growth = @metrics.pluck(:date, :user_count)
  end

  def create
    @metric = @startup.metrics.build(metric_params)
    if @metric.save
      redirect_to startup_metrics_path(@startup), notice: 'Metric was successfully added.'
    else
      render :new
    end
  end

  private

  def set_startup
    @startup = current_user.startup
  end

  def set_metric
    @metric = @startup.metrics.find(params[:id])
  end

  def metric_params
    params.require(:metric).permit(:date, :revenue, :user_count, :churn_rate, :cac, :ltv)
  end
end
