class User < ActiveRecord::Base

	require Rails.root.join('lib', 'devise', 'encryptors', 'md5')
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :md5


  has_and_belongs_to_many :places
  # md5# password format
  PASSWORD_REGEX = /^[a-f0-9]{32}$/i

  validates :password, :format => PASSWORD_REGEX
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  # attr_accessible :title, :body

  def password_salt
  'no salt'
  end

  def password_salt=(new_salt)
  end
end
