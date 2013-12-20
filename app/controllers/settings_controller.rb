class SettingsController < ApplicationController
  before_action :activate_user_wall
  
  def edit
    @user = current_user
  end

  def update
    if @user = current_user.update_attributes(params[:user].permit(:slug, :phone))
      flash[:success] = "Settings updated"
    else
      flash[:error] = current_user.errors.empty? ? "Error" : current_user.errors.full_messages.to_sentence
    end
    redirect_to settings_path
  end
end