class ScheduleController < ApplicationController
  def index
    Schedule.all
  end

  def show
    Schedule.find(params[:id])
  end

  def create
    Schedule.create
end
