class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  ROLE = { 'Admin' => 0, 'User' => 1 }.freeze

  enum role_id: ROLE

  has_many :reward_points

  validates :email, presence: true, uniqueness: { scope: :role_id }, format: { with: URI::MailTo::EMAIL_REGEXP  }
  validates :password, length: { minimum: 8 }, allow_blank: true

  def self.find_for_database_authentication(conditions={})
    where(role_id: 'Admin').where("email = :value", value: conditions[:email]).first
  end

end
