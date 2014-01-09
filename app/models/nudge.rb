class Nudge < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  validate :recipient_not_nudged_recently

  private

  def recipient_not_nudged_recently
    errors.add(:someone_else, 'has nudged this user in the last 24 hours') unless Nudge.where(recipient_id: self.recipient_id).where(['created_at > ?', Time.now - 24.hours]).empty?
  end
end