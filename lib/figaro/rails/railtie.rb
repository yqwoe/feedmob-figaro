require 'figaro/apollo_client'
require 'figaro/apollo_portal'
require 'figaro/rails/apollo_config'
require 'figaro/rails/apollo_credentials'

module Figaro
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        begin
          # Load apollo.yml
          ApolloConfig.new.load
          # Load credentials
          ApolloCredentials.new.load

          host = ::ENV['APOLLO_HOST']
          env = ::ENV['APOLLO_ENV']
          appId = ::ENV['APOLLO_APP_ID']
          cluster = ::ENV['APOLLO_CLUSTER']
          namespaces = ::ENV['APOLLO_NAMESPACES']
          credentails = ::ENV[appId]

          options = {
            host: host,
            env: env,
            app_id: appId,
            cluster_name: cluster,
            namespace_names: namespaces.split(',').map { |item| item.strip },
            credentails: credentails

          }

          if ::ENV['SKIP_APOLLO'].blank? && (::Rails.env.stage? || ::Rails.env.production?)
            Figaro::ApolloPortal.new(**options).start
          end
        rescue => e
          puts "[Apollo] start error: #{e}"
        ensure
          Figaro.load
        end
      end
    end
  end
end
