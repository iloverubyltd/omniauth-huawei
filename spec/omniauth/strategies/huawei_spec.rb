# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Huawei do
  context 'client' do
    describe '#options' do
      subject { OmniAuth::Strategies::Huawei.new({}) }

      it 'should have correct name' do
        expect(subject.options.name).to eq('huawei')
      end

      it 'should have correct site' do
        expect(subject.options.client_options.site)
          .to eq('https://oauth-login.cloud.huawei.com')
      end

      it 'should have correct authorize url' do
        expect(subject.options.client_options.authorize_url)
          .to eq('/oauth2/v3/authorize')
      end

      it 'should have correct token url' do
        expect(subject.options.client_options.token_url)
          .to eq('/oauth2/v3/token')
      end

      it 'should have correct certs url' do
        expect(subject.options.client_options.certs_url)
          .to eq('/oauth2/v3/certs')
      end

      it 'should indicate that the provider ignores the state parameter' do
        expect(subject.options.provider_ignores_state).to eq false
      end
    end

    context '#email_access_allowed?' do
      subject { OmniAuth::Strategies::Huawei.new({}) }

      it 'should not allow email if scope is nil' do
        expect(subject.options['scope']).to be_nil
        expect(subject).to_not be_email_access_allowed
      end

      it 'should allow email if scope is email' do
        subject.options['scope'] = 'email'
        expect(subject).to be_email_access_allowed
      end

      xit 'should allow email if scope includes email' do
        subject.options['scope'] = 'email profile'
        expect(subject).to be_email_access_allowed
      end

      it 'should not allow email if scope does not include email' do
        subject.options['scope'] = 'profile'
        expect(subject).not_to be_email_access_allowed
      end
    end

    context '#extra.scope' do
      xit 'returns the scope on the returned access_token' do
        expect(subject.scope).to eq('user')
      end
    end
  end
end
