class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :posts,
    class_name: "Post",
    primary_key: :id,
    foreign_key: :author_id

  has_many :subs,
    class_name: "Sub",
    primary_key: :id,
    foreign_key: :moderator_id,
    dependent: :destroy

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pd = BCrypt::Password.new(self.password_digest)
    pd.is_password?(password)
  end

  def reset_session_token!
    generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end


private
  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

end
