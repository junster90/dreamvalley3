class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mindvalley
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.staff?
      @user.save
      sign_in_user
    else
      flash[:error] = "Sorry, you're not authorised."
      redirect_to root_path
    end
  end

  def failure
  end

  private

  def sign_in_user
    request.env['omniauth.origin'] ||= root_url
    sign_in_and_redirect @user, notice: 'Signed in!', event: :authentication
  end
end
