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
    elsif @user
      @user.send_failed_status_message
    else
      send_failed_message_to_number(params[:From])
    end
  end

  private

  def send_failed_message_to_number(phone_number)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.account.sms.messages.create(
      from: '+13472692048',
      to: phone_number,
      body: 'Please add your phone number to your Currently account to update your status.'
    )
  end

end