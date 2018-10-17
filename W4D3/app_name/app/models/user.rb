class User < ApplicationRecord
  validates :username, :session_token, presence: true
  validates :session_token, :password_digest, uniqueness: true
  # receive password typed in by user.
  validates :password_digest, presence: { message: 'Invalid: Insert characters for password.' }
  # validates :password_digest, length: { minimum: 12, allow_nil: true }
  # Write #password=
    # This method sets @password equal to the argument given so that the appropriate validation can happen
    # This method also encrypts the argument given and saves it as this user's password_digest

  # so we change prev validation to :password and call / pass this through attr
  # password is encrypted by BCRYPT
  validates :password, length: { minimum: 12, allow_nil: true }
  attr_accessor :password
  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    # returns the first item or nil.
    user = User.find_by(username: username)

    # The BCrypt::Password class has an instance method, #is_password?.
    # The method takes a string, hashes the string, and compares it with the BCrypt::Password contents.
    # password is checked via .is_password?

    # example :
    # password_hash = BCrypt::Password.create('my_secret_password')
    # # => "$2a$10$sl.3R32Paf64TqYRU3DBduNJkZMNBsbjyr8WIOdUi/s9TM4VmHNHO"
    # password_hash.is_password?('my_secret_password')
    # # => true
    # password_hash.is_password?('not_my_secret_password')
    if user && BCrypt::Password.new(user.password_digest).is_password?(password)
      return user
    else
      return nil
    end
  end

  #This method resets the user's session_token and saves the user
def reset_session_token!

  self.session_token = User.generate_session_token
  self.save!
  self.session_token

end

# returns a 16-digit pseudorandom string
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

private
 def ensure_session_token
    # we must be sure to use the ||= operator instead of = or ||, otherwise
    # we will end up with a new session token every time we create
    # a new instance of the User class. This includes finding it in the DB!
   self.session_token ||= self.class.generate_session_token
 end

# method sets @password equal to arg given so that appropriate validation can happen.
# method encypts arg given and saves as user's password_digest
# attr_reader for it to occur
 def password=(password)
   @password = password
   self.password_digest = BCrypt::Password.create(password)
 end
end
