class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:mindvalley]

  validate :is_staff
  validates :first_name, :last_name, presence: true

  has_many :goals

  def self.from_omniauth(auth)
    user = where(provider: auth["provider"], uid: auth["uid"].to_s).first || where(email: auth["info"]["email"]).first || self.new()
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.first_name = auth["info"]["first_name"]
    user.last_name = auth['info']['last_name']
    user.email = auth["info"]["email"]
    user.token = auth["credentials"]["token"]
    user.id_token = auth["credentials"]["id_token"]
    return user
  end

  def staff?
    self.email.ends_with?("@mindvalley.com")
  end

  protected

  def is_staff
    errors.add(:email, "is not a staff's email") unless staff?
  end
end
