# frozen_string_literal: true

module OmniAuth
  module Huawei
    class JWKURLLoader
      def initialize(client, url = nil)
        @client = client
        @url    = url || client.options[:certs_url]
      end

      attr_accessor :client
      attr_accessor :url

      def call(options)
        client.request(:get, url, options).parsed
      end
    end
  end
end
