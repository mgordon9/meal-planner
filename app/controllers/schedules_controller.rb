class SchedulesController < ApplicationController
  def index
    render json: Schedule.all
  end

  def show
    render json: Schedule.find(params[:id])
  end

  def create
    render json: Schedule.create
  end
end
