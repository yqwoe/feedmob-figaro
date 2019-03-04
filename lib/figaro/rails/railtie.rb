require 'figaro/apollo_client'

module Figaro
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        begin
          host = ::ENV['APOLLO_HOST'] || 'http://configservice.apollo:8080'
          appId = ::ENV['APOLLO_APP_ID']
          cluster = ::ENV['APOLLO_CLUSTER'] || 'default'

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
