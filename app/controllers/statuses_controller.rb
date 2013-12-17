class StatusesController < ApplicationController

  def create
    @status = current_user.statuses.new(params[:status].permit(:content))
    if @status.save
      redirect_to user_path(@status.try(:user).try(:slug))
    end
  end

end