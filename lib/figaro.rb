require "figaro/error"
require "figaro/env"
require "figaro/application"
require 'figaro/apollo_portal'
require 'figaro/rails/apollo_config'
require 'figaro/rails/apollo_credentials'

module Figaro
  extend self

  attr_writer :adapter, :application

  def env
    Figaro::ENV
  end

  def adapter
    @adapter ||= Figaro::Application
  end

  def application
    @application ||= adapter.new
  end

  def load
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
      application.load
    end
  end

  def require_keys(*keys)
    missing_keys = keys.flatten - ::ENV.keys
    raise MissingKeys.new(missing_keys) if missing_keys.any?
  end
end

require "figaro/rails"
