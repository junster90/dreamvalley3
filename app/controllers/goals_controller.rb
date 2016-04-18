class GoalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals
  end

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

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    goal = Goal.find(params[:id])
    goal.update_attributes(goal_params)
    if goal.save
      redirect_to user_goal_path(current_user, goal)
    else
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_goals_path(current_user)
  end

  private
  def goal_params
    params.require(:goals).permit(:description, :category)
  end 
end
