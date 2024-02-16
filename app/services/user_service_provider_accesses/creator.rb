module UserServiceProviderAccesses
  # grants service provider access to a user
  class Creator
    def initialize(grantor:)
      @grantor = grantor
    end

    def create(user_service_provider_access_params)
      # users must enter a username/email that can uniquely identify a user
      # user_id is a conscious choice so that the param can be overwritten as is, even though something like "user" or "user_stub" would be more appropriate => to be sure, see that it matches the name of the user selection input in user_service_provider_accesses/_fields.html.erb
      find_user = Users::Finder.new.find(user_service_provider_access_params[:user_id])

      # if the value has an exact match (1 and only 1)
      if user = find_user.exact_match
        # set the user's ID directly
        user_service_provider_access_params[:user_id] = user.id

        # create the access
        user_service_provider_access = UserServiceProviderAccess.create(user_service_provider_access_params)

        # return the created ActiveRecord
        Result.new(user_service_provider_access)
      # otherwise, there wasn't an obvious user match
      else
        # return the list of potential users, if any
        Result.new(nil, find_user.partial_matches)
      end
    end

    class Result
      attr_reader :user_service_provider_access, :potential_users

      def initialize(user_service_provider_access = nil, potential_users = [])
        @user_service_provider_access = user_service_provider_access
        @potential_users = potential_users
      end

      def created?
        @user_service_provider_access&.valid?
      end

      def created
        @user_service_provider_access
      end

      def potential_users
        @potential_users
      end
    end
  end
end
