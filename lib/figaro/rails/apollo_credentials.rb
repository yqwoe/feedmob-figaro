module Figaro
  module Rails
    class ApolloCredentials < Figaro::Application
      private 
      
      def default_path
        rails_not_initialized! unless ::Rails.root

        "#{Dir.home}/.apollo/credentials"
      end

      def default_environment
        ::Rails.env
      end

      def rails_not_initialized!
        raise RailsNotInitialized
      end
    end

  end
end
