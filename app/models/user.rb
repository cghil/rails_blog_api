class User < ActiveRecord::Base
	validates :auth_token, uniqueness: true
  validates :email, :username, presence: true
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_confirmation_of :password

  include Gravtastic
  gravtastic

  before_create :generate_authentication_token!
  has_many :questions, dependent: :destroy
  has_many :comments, through: :questions, dependent: :destroy

  def generate_authentication_token!
  	begin
  		self.auth_token = Devise.friendly_token
  	end while self.class.exists?(auth_token: auth_token)
  end
end