class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mindvalley
    @user = User.from_omniauth(request.env['omniauth.auth'])
    redirect_to root_path
  end

  def failure
  end
end
