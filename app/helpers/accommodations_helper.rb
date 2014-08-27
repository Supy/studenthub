module AccommodationsHelper

    def humanize_enums(pairs)
        pairs.map { |p| [p.first.to_s.humanize, p.last] }
    end

end
