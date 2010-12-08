require 'json'
require 'open-uri'
require 'timeout'
require 'digest/sha1'

$:.unshift(File.dirname(__FILE__))

require 'gcoder/version'
require 'gcoder/geocoder'
require 'gcoder/storage'
require 'gcoder/resolver'

module GCoder
  class GeocoderError < StandardError; end
  class NotImplementedError < StandardError; end
  class TimeoutError < StandardError; end

  DEFAULT_CONFIG = {
    :api_key        => nil,
    :timeout        => 5,
    :append         => nil,
    :region         => nil,
    :bounds         => nil,
    :storage        => nil,
    :storage_config => nil
  }.freeze

  def self.config
    @config ||= DEFAULT_CONFIG.dup
  end

  def self.connect(options = {})
    Resolver.new(options)
  end
end
