class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = current_user.startup.reports.order(created_at: :desc)
  end

  def show
    authorize! :read, @report
  end

  def new
    @report = current_user.startup.reports.build
  end

  def create
    @report = current_user.startup.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content, :report_type, :period, attachments: [])
  end
end
