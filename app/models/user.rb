# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  # basically, the method realizes the authentication system
  has_secure_password

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }     #salva mettendo la mail tutta minuscola
  # call the create_remember_token private method before saving the user
  before_save :create_remember_token      #metodo che viene definito al fondo della pagina

  # name must be always present and with a maximum length of 50 chars
  validates :name, presence: true, length: { maximum: 50 };

  # email allowed format representation (expressed as a regex)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  # email must be always present, unique and with a specific format
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # password must be always present, and with a minimum length of 6 chars
  validates :password, presence: true, length: { minimum: 6 }

  # password_confirmation must be always present
  validates :password_confirmation, presence: true

  private     #questi metodi sono privati

  def create_remember_token
    # create a random string, save for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64  #serve per  memorizzare come token un numero casuale difficilmente replicabile
  end



end
