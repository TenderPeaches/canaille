class Clients::CoordinateEditCancellationsController < ApplicationController
    def new
        set_client
    end

    private
    def set_client
        @client = Client.find_by_id(params[:client_id])
    end
end
