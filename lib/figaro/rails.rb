begin
  require "rails"
rescue LoadError
else
  require 'figaro/rails/apollo_config'
  require 'figaro/rails/apollo_credentials'
  require "figaro/rails/application"
  require "figaro/rails/railtie"

  Figaro.adapter = Figaro::Rails::Application
  Figaro.apollo_config_adapter = Figaro::Rails::ApolloConfig
  Figaro.apollo_credential_adapter = Figaro::Rails::ApolloCredentials
end
