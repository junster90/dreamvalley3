class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
  end 

  def new
  end

  def create
    goal = current_user.goals.new(goal_params)

    if goal.save
      redirect_to user_goal_path(current_user, goal)
    else
      render :new
    end

  end 

  private
  def goal_params
    params.require(:goals).permit(:description, :category)
  end 
end
