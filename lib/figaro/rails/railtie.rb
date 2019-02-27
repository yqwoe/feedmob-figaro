require 'figaro/apollo_client'

module Figaro
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        begin
          if ::Rails.env.stage? || ::Rails.env.production?
            Figaro::ApolloClient.new.start
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
