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
    @user = User.find_by_phone(params[:From])
    if @user && @user.statuses.create(content: params[:Body])
      @user.send_successful_status_message
    elsif @user
      @user.send_failed_status_message
    else
      send_failed_message_to_number(params[:From])
    end
    redirect_to root_path
  end

  def sms_ping
    start_twilio_client
    if send_text_with('Send a text to this Currently number to update your status!', current_user.phone)
      flash[:success] = 'A text message was sent to your phone number!'
    end
    redirect_to settings_path
  end

  private

  def send_failed_message_to_number(phone_number)
    start_twilio_client
    send_text_with('Please add your phone number to your Currently account to update your status.', phone_number)
  end

  def start_twilio_client
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_text_with(message, phone_number)
    @client.account.sms.messages.create(
      from: '+13472692048',
      to: phone_number,
      body: message
    )
  end

end