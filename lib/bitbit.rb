require 'net/http'
require 'json'
require 'bigdecimal'

require 'bitbit/client'

module Bitbit
  VERSION = '0.1.0'
  APIClientError = Class.new(StandardError)

  def self.client
    Client.new(ENV['BITBIT_CLIENT_ID'], ENV['BITBIT_CLIENT_SECRET'])
  end
end
