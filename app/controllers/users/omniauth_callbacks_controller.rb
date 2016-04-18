class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def mindvalley
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.staff?
      @user.save
      sign_in @user, notice: 'Signed in!', event: :authentication
      redirect_to user_goals_path(current_user)
    else
      flash[:error] = "Sorry, you're not authorised."
      redirect_to root_path
    end
  end

  def failure
  end

end
