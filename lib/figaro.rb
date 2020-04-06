require "figaro/error"
require "figaro/env"
require "figaro/application"
require 'figaro/apollo_portal'

module Figaro
  extend self
  attr_writer :adapter, :application, :apollo_config, :apollo_credential, :apollo_config_adapter, :apollo_credential_adapter

  def env
    Figaro::ENV
  end

  def adapter
    @adapter ||= Figaro::Application
  end

  def application
    @application ||= adapter.new
  end

  def apollo_config_adapter
    @apollo_config_adapter ||= Figaro::Application
  end

  def apollo_config
    @apollo_config ||= apollo_config_adapter.new
  end

  def apollo_credential_adapter
    @apollo_credential_adapter ||= Figaro::Application
  end

  def apollo_credential
    @apollo_credential ||= apollo_credential_adapter.new
  end

  def load
    begin
      # Initilize Apollo configuration
      apollo_config.load
      apollo_credential.load

      host = ::ENV['APOLLO_HOST']
      apollo_env = ::ENV['APOLLO_ENV']
      appId = ::ENV['APOLLO_APP_ID']
      cluster = ::ENV['APOLLO_CLUSTER']
      namespaces = ::ENV['APOLLO_NAMESPACES']
      credentails = ::ENV[appId]

      options = {
        host: host,
        env: apollo_env,
        app_id: appId,
        cluster_name: cluster,
        namespace_names: namespaces.split(',').map { |item| item.strip },
        credentails: credentails
      }

      if !options.values.include?(nil) &&
          ::ENV['SKIP_APOLLO'].blank? &&
          (::Rails.env.stage? || ::Rails.env.production?)
        Figaro::ApolloPortal.new(**options).start
      end
    rescue => e
      puts "[Apollo] start error: #{e}"
    ensure
      application.load
    end
  end

  def require_keys(*keys)
    missing_keys = keys.flatten - ::ENV.keys
    raise MissingKeys.new(missing_keys) if missing_keys.any?
  end
end

require "figaro/rails"
