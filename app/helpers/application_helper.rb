module ApplicationHelper
    # returns a temporary ID for objects that have not been created yet
    def temp_id
        Time.now.to_i
    end
end
