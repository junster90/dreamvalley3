class UsersController < ApplicationController
  before_action :set_user

  def show
    # @goals = CollectUserGoalService.new(@user).collect_all
    @goals = @user.goals
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def sign_in
    redirect_to user_omniauth_authorize_path(:mindvalley) unless current_user
  end
end
