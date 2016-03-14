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

    def send(address, amount, memo, sequence_id=nil)
      amount_to_decimal = "%f" % BigDecimal.new(amount.to_s).to_s

      body = {
        'amount' => amount_to_decimal,
        'address' => address,
        'memo' => memo,
        'sequenceId' => sequence_id,
        'clientId' => @client_id,
        'clientSecret' => @client_secret
      }

      begin
        req = Net::HTTP::Put.new("/prepaid/wallet/send", { 'Content-type' => 'text/json' })
        req.body = body.to_json
        response = http.request(req)

        case response
        when Net::HTTPClientError
          begin
            message = JSON.parse(response.body)['message']
          rescue
            message = response.body
          end
          raise Bitbit::APIClientError.new(message)
        end
        return response
      rescue Errno::ECONNRESET, Errno::EAGAIN, Net::ReadTimeout
        raise Bitbit::APIClientError.new('Could not connect to API endpoint')
      end
    end

    def address(opts={})
      body = {
        'clientId' => @client_id,
        'clientSecret' => @client_secret,
      }

      body.merge!(opts)

      req = Net::HTTP::Post.new('/rebit/address', { 'Content-type' => 'text/json' })
      req.body = body.to_json

      http.request(req)
    end

    private

    def http
      Net::HTTP.new(api_uri.host, api_uri.port)
    end

    def api_uri
      URI(ENV['BITBIT_HOST']) || "https://api.bitbit.cash"
    end
  end
end
