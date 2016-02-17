require 'spec_helper'

RSpec.describe Bitbit::Client do
  it 'instantiate bitbit client' do
    expect(Bitbit::Client.new('test', '123')).to be_instance_of Bitbit::Client
  end
end
