module ApplicationHelper
    # returns a temporary ID for objects that have not been created yet
    def temp_id
        Time.now.to_i
    end

    # checks if a record is created or needs to be updated
    def must_create?(record)
        record.new_record?
    end

    # when errors, do nothing and return error feedback
    def render_error(model = nil)
        @model = model
        render :error, status: :unprocessable_entity
    end

    # devise helpers
    def devise_mapping
      Devise.mappings[:user]
    end

    ## devise auth links
    def link_to_login
      link_to t('models.session.create_title'), new_session_path(:user), class: "button"
    end

    def link_to_sign_up
      link_to t('models.user.create_title'), new_registration_path(:user), class: "button"
    end

    def link_to_forgot_password
      link_to "Forgot your password?", new_password_path(:user), class: "button"
    end

    # hint to give direct, immediate feedback to user
    def hint(text)
      tag.div class: "hint" do
        text
      end
    end

    # debugging
    def raise_hell
      raise 'hell'
    end
end
