require "tempfile"

module Figaro
  describe ApolloClient do
    describe '#init' do
      it 'should support custom config file not set' do
        client = Figaro::ApolloClient.new(nil, nil, nil, nil)
        expect(client.instance_variable_get(:@custom_config_file)).to eq([])
      end

      it 'should support string config' do
        client = Figaro::ApolloClient.new(nil, nil, nil, 'aaa.json')
        expect(client.instance_variable_get(:@custom_config_file)).to eq(['aaa.json'])
      end

      it 'should support array config' do
        client = Figaro::ApolloClient.new(nil, nil, nil, "[\"test1.json\", \"test2.json\"]")
        expect(client.instance_variable_get(:@custom_config_file)).to eq(['test1.json', 'test2.json'])
      end
    end
  end
end
