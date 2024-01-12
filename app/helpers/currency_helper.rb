module CurrencyHelper
    def to_currency(decimal)
        "#{'%.2f' % decimal}$"
    end

    def price_range(min, max)
        "#{to_currency(min)} - #{to_currency(max)}"
    end
end
