class NudgesController < ApplicationController
  before_action :activate_user_wall

  def create
    nudge = current_user.sent_nudges.new(params[:nudge].permit(:recipient_id))
    if nudge.save
      flash[:success] = 'Nudge sent!'
    else
      flash[:error] = nudge.errors.empty? ? "Error" : nudge.errors.full_messages.to_sentence
    end
    redirect_to connections_path
  end

end