require "refile/tinypng/version"
require 'net/https'
require 'uri'

module Refile
  # Refile::TinyPNG.configure do |config|
  #   config.key = ENV['TINYPNG_KEY']
  # end
  # %i(fill fit limit pad convert).each do |name|
  #   Refile.processor(name, Refile::TinyPNG.new(Refile::MiniMagick.new(name)))
  # end
  class TinyPNG
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Refile::TinyPNG::Configuration.new
    end

    class Configuration
      attr_accessor :key
    end

    def initialize(processor)
      @processor = processor
    end

    def call(*args)
      processed_file = @processor.call(*args)
      processed_file.close unless processed_file.closed?

      key = Refile::TinyPNG.configuration.key
      input = processed_file.path
      output = processed_file.path

      uri = URI.parse('https://api.tinypng.com/shrink')

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.basic_auth('api', key)

      response = http.request(request, File.binread(input))
      if response.code == '201'
        File.binwrite(output, http.get(response['location']).body)
      else
        raise response.body
      end

      ::File.open(processed_file.path, 'rb')
    end
  end

end
