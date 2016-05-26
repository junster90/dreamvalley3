class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @goals = Goal.order("RANDOM()").first(5)
  end

  private
end
