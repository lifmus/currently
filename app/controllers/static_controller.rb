class StaticController < ApplicationController
  layout 'static_layout'

  def home
    redirect_to friends_path if current_user
  end
end