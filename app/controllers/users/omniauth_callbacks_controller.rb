class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mindvalley
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.staff?
      sign_in @user
      redirect_to root_path
    else
      flash[:error] = "Sorry, you're not authorised."
      redirect_to root_path
    end
  end

  def failure
  end
end
