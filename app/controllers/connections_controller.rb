class ConnectionsController < ApplicationController
  before_action :activate_user_wall

  def index
    redirect_to 'static#home' unless current_user
    @facebook_friends = current_user.facebook_friends
    @currently_friends = current_user.leaders.order('status_last_updated_at DESC')
  end

  def create
    @connection = current_user.leader_connections.new(params[:connection].permit(:leader_id))
    if @connection.save
      flash[:success] = 'Follow successful!'
    else
      flash[:error] = @connection.errors.empty? ? 'Error' : @connection.errors.full_messages.to_sentence
    end
    redirect_to connections_path
  end

  def destroy
    @connection = Connection.find(params[:id])
    if @connection.destroy
      flash[:success] = 'Unfollow successful'
      redirect_to connections_path
    else
      flash[:error] = @connection.errors.empty? ? 'Error' : @connection.errors.full_messages.to_sentence
    end
  end
end