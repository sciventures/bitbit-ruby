require 'net/http'
require 'json'
require 'bigdecimal'

require 'bitbit/client'

module Bitbit
  VERSION = '0.1.0'
  APIClientError = Class.new(StandardError)
end
