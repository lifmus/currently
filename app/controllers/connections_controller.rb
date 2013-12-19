class ConnectionsController < ApplicationController

  def create
    @connection = current_user.leader_connections.new(params[:connection].permit(:leader_id))
    if @connection.save
      flash[:success] = 'Follow successful!'
    else
      flash[:error] = @connection.errors.empty? ? "Error" : @connection.errors.full_messages.to_sentence
    end
    redirect_to friends_path
  end

  def destroy
    @connection = Connection.find(params[:id])
    if @connection.destroy
      flash[:success] = 'Unfollow successful'
      redirect_to friends_path
    else
      flash[:error] = @connection.errors.empty? ? "Error" : @connection.errors.full_messages.to_sentence
    end
  end
end