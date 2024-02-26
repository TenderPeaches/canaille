class ServiceRequestSearchesController < ApplicationController
  def new
    set_service_provider
    search_result = ServiceProviders::ServiceRequestFinder.new(@service_provider).find
    @service_requests = search_result.found
  end

  private
  def set_service_provider
      @service_provider = ServiceProvider.find_by_id(params[:id])
  end
end
