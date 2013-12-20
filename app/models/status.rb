class Status < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true, length: { maximum: 200, message: 'must be less than 200 characters' }

  after_create :update_user_status_last_updated_at

  private

  def update_user_status_last_updated_at
    self.user.update_attribute('status_last_updated_at', self.created_at)
  end
end