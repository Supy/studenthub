class IsbnValidators
    def self.valid_isbn?(isbn)
        if isbn.nil? or !isbn.is_a?(String)
            raise 'ISBN must be a non-empty string.'
        end

        if isbn.length == 10
            return validate_isbn10(isbn)
        elsif isbn.length == 13
            return validate_isbn13(isbn)
        end

        return false
    end

    private

    def self.validate_isbn10(isbn)
        if isbn.match(/^(?:\d[\ |-]?){9}[\d|X]$/i)
            isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
            check_digit = isbn_values.pop
            check_digit = (check_digit.upcase == 'X') ? 10 : check_digit.to_i

            sum = 0
            isbn_values.each_with_index do |value, index|
                sum += (index + 1) * value.to_i
            end

            (sum % 11) == check_digit
        else
            false
        end
    end

    def self.validate_isbn13(isbn)
        if isbn.match(/^(?:\d[\ |-]?){13}$/i)
            isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
            check_digit = isbn_values.pop.to_i # last digit is check digit

            sum = 0
            isbn_values.each_with_index do |value, index|
                multiplier = (index % 2 == 0) ? 1 : 3
                sum += multiplier * value.to_i
            end

            result = (10 - (sum % 10))
            result = 0 if result == 10

            result == check_digit
        else
            false
        end
    end
end