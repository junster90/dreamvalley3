module LoginHelper
  def create_and_login_user
    user = create_user
    login_user(user)
    return user
  end

  def create_user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:mindvalley] = build(:staff_hash)
    user = User.create!(
      password: "password",
      password_confirmation: "password",
      provider: OmniAuth.config.mock_auth[:mindvalley]["provider"],
      uid: OmniAuth.config.mock_auth[:mindvalley]["uid"],
      first_name: OmniAuth.config.mock_auth[:mindvalley]["info"]["first_name"],
      last_name: OmniAuth.config.mock_auth[:mindvalley]['info']['last_name'],
      email: OmniAuth.config.mock_auth[:mindvalley]["info"]["email"],
      token: OmniAuth.config.mock_auth[:mindvalley]["credentials"]["token"],
      id_token: OmniAuth.config.mock_auth[:mindvalley]["credentials"]["id_token"]
    )
    return user
  end

  def login_user(user)
    login_as(user, scope: :user)
  end
end