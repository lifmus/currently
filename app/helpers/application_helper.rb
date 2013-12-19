module ApplicationHelper
  def time_ago(object)
    created_at_time = object.try(:created_at)
    created_at_time ? time_ago_in_words(created_at_time) + ' ago' : ''
  end
end
