module Figaro
  module Rails
    class ApolloConfig < Figaro::Application
      private 
      
      def default_path
        rails_not_initialized! unless ::Rails.root

        ::Rails.root.join("config", "apollo.yml")
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
