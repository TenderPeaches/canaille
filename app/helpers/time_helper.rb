module TimeHelper
    def time_format(datetime)
        datetime.strftime("%H:%M:%S")
    end

    def date_format(datetime)
        datetime.strftime("%Y/%m/%d")
    end

    def datetime_format(datetime)
        "#{date_format(datetime)} #{time_format(datetime)}"
    end
end
