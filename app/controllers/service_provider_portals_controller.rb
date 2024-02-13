class ServiceProviderPortalsController < ApplicationController
  before_action :authorize 

  def show
    set_service_provider
    render "service_providers/portal"
  end

  private
  def set_service_provider
    @service_provider = ServiceProvider.find_by_id(params[:id])

    # if @service_provider is nil, try the current user's default service provider
    unless @service_provider
      @service_provider = current_user&.service_provider
    end
  end
end
