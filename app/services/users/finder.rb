module Users
    class Finder
      def initialize

      end

      def find(search)
        # try to find by exact username match
        user = User.find_by_username(search)
        # if not found, try an exact match with the email
        unless user
            user = User.find_by_email(search)
        end
        # if still not found, search users whose username or email contains params[:user]
        unless user
            search = "%#{search}%"
            potential_users = User.where("username like ?", search).or(User.where("email like ?", search))
        end

        Result.new(user, potential_users)
      end

      class Result
        def initialize(user = nil, potential_users = nil)
          @user = user
          @potential_users = potential_users
        end

        def none?
          @user.nil? && potential_users.nil?
        end

        def exact_match
          @user
        end

        def partial_matches
          @potential_users
        end
      end
    end
end
