class Status < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true, length: { maximum: 200, message: 'must be less than 200 characters' }
end