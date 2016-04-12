class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:mindvalley]

  validate :is_staff
  validates :first_name, :last_name, presence: true

  def self.from_omniauth(auth)

  end

  def staff?
    self.email.ends_with?("@mindvalley.com")
  end

  protected

  def is_staff
    errors.add(:email, "is not a staff's email") unless staff?
  end
end
