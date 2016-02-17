require 'json'
require 'spec_helper'

RSpec.describe Bitbit::Client do
  let(:client_id) { ENV['BITBIT_CLIENT_ID'] }
  let(:client_secret) { ENV['BITBIT_CLIENT_SECRET'] }

  subject { described_class.new(client_id, client_secret) }

  describe '#address' do
    it 'returns invoice address' do
      resp = subject.address
      json = JSON.parse(resp.body)
      puts json
    end
  end
end
