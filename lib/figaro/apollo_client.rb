module Figaro
  class ApolloClient
    CONFIG_FILE = [
      'application.yml',
      'sidekiq.yml'
    ].freeze

    def initialize
      @host = ENV['APOLLO_HOST'] || 'http://configservice.apollo:8080'
      @appId = ENV['APOLLO_APP_ID'] || 'feedmob-time-off'
      @cluster = ENV['APOLLO_CLUSTER'] || 'default'
      # @namespace = ENV['APOLLO_NAMESPACE'] || 'application.yml'
    end

    def start
      p '[Apollo] start pulling configurations...'
      file_loop do |file|
        result = response
        message = result['message']

        if message.blank?
          configurations = result['configurations']['content']
          release_key = result['releaseKey']
          write_yml(file, configurations, release_key)
        else
          p "[Apollo] #{message}"
        end
      end
    end

    def file_loop
      CONFIG_FILE.each do |file|
        @url = url(file)
        yield(file)
      end
    end

    def write_yml(file, configs, release_key)
      if configs.strip.empty?
        p "[Apollo] Skip write #{file} with blank configs by relase: #{release_key}"
        return
      end
      File.write("config/#{file}", configs)
      p "[Apollo] writed to local successfully with release: #{release_key}"
    end

    def response
      JSON.parse(Net::HTTP.get(uri))
    rescue Net::ReadTimeout, Net::OpenTimeout
      p '[Apollo] Application center can not connect now!'
    end

    def uri
      URI.parse(@url)
    end

    def url(file)
      "#{@host}/configs/#{@appId}/#{@cluster}/#{file}"
    end
  end
end
