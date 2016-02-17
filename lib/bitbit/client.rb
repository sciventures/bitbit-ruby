module Bitbit
  class Client
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def rates
      req = Net::HTTP::Get.new('/rates/peso')
      http.request(req)
    end

    def send(address, amount, memo)
      amount_to_decimal = "%f" % BigDecimal.new(amount.to_s).to_s

      body = {
        'amount' => amount_to_decimal,
        'address' => address,
        'memo' => memo,
        'clientId' => @client_id,
        'clientSecret' => @client_secret
      }

      begin
        req = Net::HTTP::Put.new("/prepaid/wallet/send", { 'Content-type' => 'text/json' })
        req.body = body.to_json
        response = http.req(req)

        case response
        when Net::HTTPClientError
          raise Bitbit::APIClientError.new('API req error')
        end
        return response
      rescue Errno::ECONNRESET, Errno::EAGAIN, Net::ReadTimeout
        raise Bitbit::APIClientError.new('Could not connect to API endpoint')
      end
    end

    def address
      body = {
        'clientId' => @client_id,
        'clientSecret' => @client_secret
      }

      req = Net::HTTP::Post.new('/rebit/address', { 'Content-type' => 'text/json' })
      req.body = body.to_json

      http.request(req)
    end

    private

    def http
      Net::HTTP.new(api_uri.host, api_uri.port)
    end

    def api_uri
      URI(ENV['BITBIT_HOST'])
    end
  end
end
