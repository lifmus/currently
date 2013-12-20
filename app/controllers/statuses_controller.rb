class StatusesController < ApplicationController
  before_action       :activate_user_wall, except: [:sms_create]
  skip_before_action  :verify_authenticity_token, only: [:sms_create]

  def create
    @status = current_user.statuses.new(params[:status].permit(:content))
    if @status.save
      flash[:success] = 'Status updated!'
    else
      flash[:error] = @status.errors.empty? ? "Error" : @status.errors.full_messages.to_sentence
    end
    redirect_to connections_path
  end

  def sms_create
    @user = User.where(phone: params[:From]).try(:last)
    if @user && @user.statuses.create(content: params[:Body])
      @user.send_successful_status_message
    else
      @user.send_failed_status_message
    end
  end

end