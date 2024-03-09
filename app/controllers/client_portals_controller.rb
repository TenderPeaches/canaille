class ClientPortalsController < ApplicationController
  before_action :authorize

  def show
    set_client_user
    render "clients/portal"
  end

  private
  def set_client_user
    @user = current_user
  end
end
