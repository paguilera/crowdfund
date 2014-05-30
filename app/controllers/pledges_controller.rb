class PledgesController < ApplicationController
  before_action :set_project

  def index
    @pledges = @project.pledges
  end

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(review_params)
    if @pledge.save
      redirect_to project_pledges_path(@project), 
                    notice: "Thanks for pledging!"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:pledge).permit(:name, :email, :pledge_amount, :comment)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
