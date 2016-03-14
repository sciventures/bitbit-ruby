require 'dotenv'
Dotenv.load

require 'pry'
require 'webmock/rspec'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bitbit'
