module UsersHelper
  def time_ago
    user_last_status_time ? time_ago_in_words(user_last_status_time) + ' ago' : ''
  end

  def user_last_status_time
    @user.try(:latest_status).try(:created_at)
  end
end