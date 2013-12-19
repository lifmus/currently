class StatusesController < ApplicationController

  def create
    @status = current_user.statuses.new(params[:status].permit(:content))
    if @status.save
      flash[:success] = 'Status updated!'
    else
      flash[:error] = @status.errors.empty? ? "Error" : @status.errors.full_messages.to_sentence
    end
    redirect_to connections_path
  end

end