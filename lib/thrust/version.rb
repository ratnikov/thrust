module Thrust
  VERSION = '0.0.2.pre'

  APPENGINE_JAVA_SDK_URL = 'http://googleappengine.googlecode.com/files/appengine-java-sdk-1.7.1.zip'.freeze

  module Jars
    PRODUCTION_JARS = [ 'appengine-api.jar' ].freeze
    DEVELOPMENT_JARS = [ 'appengine-local-runtime.jar', 'appengine-api-stubs.jar' ].freeze
  end
end
