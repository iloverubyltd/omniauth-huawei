# frozen_string_literal: true

require 'addressable/uri'

RSpec::Matchers.define :match_site do |expected|
  match do |actual|
    begin
      @actual = Addressable::URI.parse(actual).site
      values_match?(expected, @actual)
    rescue Addressable::InvalidURIError
      false
    end
  end

  diffable
end

RSpec::Matchers.define :match_query_values do |expected|
  match do |actual|
    begin
      @actual = Addressable::URI.parse(actual).query_values
      values_match?(expected, @actual)
    rescue Addressable::InvalidURIError
      false
    end
  end

  diffable
end
