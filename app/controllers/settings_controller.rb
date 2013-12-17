class SettingsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    if @user = current_user.update_attributes(params[:user].permit(:slug))
      flash[:success] = "Settings updated"
    else
      flash[:error] = "#{@user.errors}"
    end
    redirect_to settings_path
  end
end