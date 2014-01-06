class StaticController < ApplicationController
  layout 'static_layout'

  def home
    redirect_to connections_path if current_user
  end

  def about
  end
end