class UsersController < ApplicationController
  def show
    @user = User.find_by_slug(params[:slug])
    @connection = Connection.where(follower_id: current_user.try(:id), leader_id: @user.id).try(:last)
  end
end