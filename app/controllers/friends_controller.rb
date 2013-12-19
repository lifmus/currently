class FriendsController < ApplicationController
  def index
    @facebook_friends = User.all
    redirect_to 'static#home' unless current_user
  end
end