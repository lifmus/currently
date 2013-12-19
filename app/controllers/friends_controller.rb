class FriendsController < ApplicationController
  def index
    redirect_to 'static#home' unless current_user
    @facebook_friends = current_user.facebook_friends
    @currently_friends = current_user.leaders
  end
end