# frozen_string_literal: true

require 'omniauth-oauth2'
require 'omniauth/strategies/huawei/jwk_url_loader'

module OmniAuth
  module Strategies
    class Huawei < OmniAuth::Strategies::OAuth2
      MANDATORY_DEFAULT_SCOPE = 'openid'

      option :client_options, site:          'https://oauth-login.cloud.huawei.com',
                              authorize_url: '/oauth2/v3/authorize',
                              token_url:     '/oauth2/v3/token',
                              certs_url:     '/oauth2/v3/certs'

      def callback_url
        full_host + script_name + callback_path
      end

      uid do
        raw_info['sub']
      end

      info do
        {
          'locale'       => raw_info['locale'],
          'picture'      => raw_info['picture'],
          'name'         => raw_info['name'],
          'family_name'  => raw_info['family_name'],
          'given_name'   => raw_info['given_name'],
          'display_name' => raw_info['display_name']
        }
      end

      # email = {
      #   'email_verified' => raw_info['email_verified'],
      #   'email' => raw_info['email']
      # }

      extra do
        hash = {}
        hash['raw_info'] = raw_info
        hash
      end

      def email
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('user').parsed
      end

      def email_access_allowed?
        return false unless options['scope']

        email_scopes = [MANDATORY_DEFAULT_SCOPE, 'email']
        scopes = options['scope'].split('+')
        (scopes & email_scopes).any?
      end

      # def raw_data
      #  @raw_data ||= access_token.params['foo']
      # end

      private

      def jwk_loader
        @jwk_loader ||= JWKUrlLoader.new(client)
      end

      def raw_info
        id_token = access_token.params['id_token']

        begin
          payload, header = JWT.decode(id_token, nil, true, {
                                         algorithms: ['RS256'],
                                         jwks:       jwk_loader
                                       })

          # p payload

          # VERIFY
          # Verify the signature.
          # JWT::Verify.verify_aud(payload, aud: options[:client_id])
        rescue StandardError => e
        end

        @data ||= access_token.params['user']
      end
    end
  end
end
