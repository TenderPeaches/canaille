class ClientPortalsController < ApplicationController
  before_action :authorize
  
  def index
    set_client_user
    render "clients/portal"
  end

  private 
  def set_client_user
    # use cilent from GET param or default to current user's client
    @user = Client.find_by_id(params(:id)).first&.user || current_user.client
    # if current user has no client, it's created here since client model doesn't have any required fields
    unless @user.client
      @user.client = Client.create(user: @user)
    end
  end
end
