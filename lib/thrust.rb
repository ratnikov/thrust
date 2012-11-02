require 'java'

require 'active_support/core_ext/class/attribute_accessors'

module Thrust
  extend self

  attr_accessor :logger
end

require 'thrust/constants'

Thrust::Constants::PRODUCTION_JARS.each do |jar|
  require File.join('vendor', 'appengine-java-sdk', jar)
end

require 'thrust/hacks'
require 'thrust/controller_extensions'
require 'thrust/datastore'
require 'thrust/logging'

require 'thrust/railtie' if defined?(::Rails)

ActiveSupport.run_load_hooks(:thrust, Thrust)
