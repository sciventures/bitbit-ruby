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

    it 'returns invoice address' do
      resp = subject.address(label: 'test')
      json = JSON.parse(resp.body)
      puts json
    end
  end

  describe '#send' do
    let(:wallet_address) { 'staoteusaoteuhs' }
    let(:amount) { 0.001 }

    it 'returns Bitbit::APIClientError with parsed message message' do
      error_message = { 'message' => 'duplicate sequence id' }.to_json

      stub_request(:put, "http://api.sci.ph/prepaid/wallet/send").
        to_return(:status => 400, :body => error_message, :headers => {})

      expect { subject.send(wallet_address, amount, 'Test', 'xx') }.
        to raise_error 'duplicate sequence id'
    end
  end
end
