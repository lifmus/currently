class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses

  has_many :follower_connections, class_name: 'Connection', foreign_key: 'leader_id'
  has_many :followers, through: :follower_connections, source: :follower
  has_many :leader_connections, class_name: 'Connection', foreign_key: 'follower_id'
  has_many :leaders, through: :leader_connections, source: :leader
  has_many :received_nudges, class_name: 'Nudge', foreign_key: 'recipient_id'
  has_many :sent_nudges, class_name: 'Nudge', foreign_key: 'sender_id'

  validates :slug, clean_username: true
  validates :slug, uniqueness: true
  validates :slug, presence: true

  TWILIO_NUMBER = '+13472692048'

  def updated_or_nudged_recently?
    self.updated_status_recently? || self.nudged_recently?
  end

  def updated_status_recently?
    self.latest_status.created_at > Time.now - 24.hours
  end

  def nudged_recently?
    !Nudge.where(recipient_id: self.id).where(['created_at > ?', Time.now - 24.hours]).empty?
  end

  def facebook_friends
    if self.leaders.empty?
      User.where.not(id: [self.id])
    else
      User.where.not(id: [self.id, self.leaders.pluck(:id)])
    end
  end

  def latest_status_content
    self.statuses.last.try(:content) || "No statuses created yet"
  end

  def latest_status
    self.statuses.try(:last)
    # Status.where(user_id: self.id, created_at: self.status_last_updated_at) not sure if this is faster
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = SecureRandom.hex(5) unless user.password
      user.slug = user.auto_generate_slug unless user.slug
      user.save!
    end
  end

  def auto_generate_slug
    User.find_by_slug(self.name.parameterize) ? self.name.parameterize + rand(10 ** 3).to_s : self.name.parameterize
  end

  def send_successful_status_message
    start_twilio_client
    @client.account.sms.messages.create(
      from: TWILIO_NUMBER,
      to: self.phone,
      body: 'Success! Your status has been updated. Check it out at http://www.usecurrently.com/' + self.slug
    )
  end

  def send_failed_status_message
    start_twilio_client
    @client.account.sms.messages.create(
      from: TWILIO_NUMBER,
      to: self.phone,
      body: 'Whoops something went wrong.'
    )
  end

  private

  def start_twilio_client
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
end
