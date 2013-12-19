class FriendsController < ApplicationController
  def index
    redirect_to 'static#home' unless current_user
  end
end