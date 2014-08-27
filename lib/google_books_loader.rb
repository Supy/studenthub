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

    private

    def self.load_book_list(isbn)
        url = API_URL % { isbn: isbn }
        response = make_request(url)

        if response.code == 200
            begin
                JSON.parse(response)
            rescue Exception => e
                logger.error "Failed to parse book information. #{e}"
                nil
            end
        else
            logger.warn "Failed to access URL #{url}. HTTP status: #{response.code}."
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