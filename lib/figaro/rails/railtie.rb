require 'figaro/apollo_client'

module Figaro
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        begin
          configs = YAML.load_file('config/apollo.yml')
          host = configs['APOLLO_HOST']
          appId = configs['APOLLO_APP_ID']
          cluster = configs['APOLLO_CLUSTER']

          if ::Rails.env.stage? || ::Rails.env.production?
            Figaro::ApolloClient.new(host, appId, cluster).start
          end
        rescue => e
          p "[Apollo] start error: #{e}"
        ensure
          Figaro.load
        end
      end
    end
  end
end
