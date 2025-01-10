class InvestmentsController < ApplicationController
  before_action :set_startup
  before_action :set_investment, only: [:show, :edit, :update, :destroy]

  def index
    @investments = @startup.investments
    @investments = @investments.by_type(params[:type]) if params[:type].present?
    @total_investments = Investment.total_amount
    
    respond_to do |format|
      format.html
      format.json { render json: @investments }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @investment }
    end
  end

  def new
    @investment = @startup.investments.build
  end

  def create
    @investment = @startup.investments.build(investment_params)

    if @investment.save
      redirect_to startup_investment_path(@startup, @investment), notice: 'Investment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @investment.update(investment_params)
      redirect_to startup_investment_path(@startup, @investment),  notice: 'Investment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @investment.destroy
    redirect_to startup_investments_url(@startup), notice: 'Investment was successfully deleted.'
end
