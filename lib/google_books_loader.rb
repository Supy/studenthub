require 'net/http'

class GoogleBooksLoader
    API_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:%{isbn}'

    def self.get_for_isbn(isbn)
        list = load_book_list(isbn)
        return false if list.nil?

        if list['totalItems'] > 0
            list['items'][0]
        else
            nil
        end
    end

    def self.has_required_elements?(gb_data, required_elements)
        required_elements.each_pair do |key, allowed_type|
            keys = key.split('_')
            tree_element = gb_data
            keys.each do |tree_key|
                unless tree_element.has_key?(tree_key)
                    Rails.logger.info "Google Book data missing required key `#{key}`."
                    return false
                end

                # Move down a level in the tree.
                tree_element = tree_element[tree_key]
            end

            # Element must be of the correct type.
            unless allowed_type.include?(tree_element.class)
                Rails.logger.info "Google Book data element `#{key}` is not of required type `#{allowed_type}`. Got `#{tree_element.class}`."
                return false
            end

            # Elements must not be empty.
            if tree_element.size == 0
                Rails.logger.info "Required Google Book data element `#{key}` is empty."
                return false
            end
        end

        true
    end

    private

    def self.load_book_list(isbn)
        url = API_URL % { isbn: isbn }
        response = make_request(url)

        if response.code.to_i == 200
            begin
                JSON.parse(response.body)
            rescue Exception => e
                Rails.logger.error "Failed to parse book information. #{e}"
                nil
            end
        else
            Rails.logger.warn "Failed to access URL #{url}. HTTP status: #{response.code}."
            nil
        end
    end

    def self.make_request(url)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)
        http.request(request)
    end
end