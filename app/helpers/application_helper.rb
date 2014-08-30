module ApplicationHelper
    def humanize_enums(pairs)
        pairs.map { |p| [p.first.to_s.humanize, p.first] }
    end

    def format_price(n)
        number_to_currency(n, unit: 'R', precision: ((n%1) > 0.001) ? 2 : 0, delimiter: ',')
    end

    def text_truncate(text, limit=100)
        truncate(text, length: limit, separator: ' ')
    end

    def bootstrap_class_for(type)
        {
            'info' => 'alert-info',
            'success' => 'alert-success',
            'notice' => 'alert-success',
            'error' => 'alert-danger',
            'alert' => 'alert-danger',
            'warning' => 'alert-warning'
        }[type] || type.to_s
    end

    def humanize_boolean(b)
        b ? 'Yes' : 'No'
    end
end
