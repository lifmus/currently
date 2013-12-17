class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  validates :slug, uniqueness: true
  validates :slug, presence: true

  def latest_status_content
    self.statuses.last.try(:content) || "No statuses created yet"
  end

  def latest_status
    self.statuses.last
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
end
