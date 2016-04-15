class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @goals = CollectUserGoalService.new(@user).collect_all
  end

  private

  def sign_in
    redirect_to user_omniauth_authorize_path(:mindvalley) unless current_user
  end
end
