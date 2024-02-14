module ApplicationHelper
    # returns a temporary ID for objects that have not been created yet
    def temp_id
        Time.now.to_i
    end

    # checks if a record is created or needs to be updated
    def must_create?(record)
        record.new_record?   
    end
end
