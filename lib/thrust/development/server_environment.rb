
module Thrust::Development
  class ServerEnvironment
    java_import 'com.google.apphosting.api.ApiProxy'

    include com.google.appengine.tools.development.LocalServerEnvironment

    def app_dir
      java.io.File.new tmpdir
    end

    def current_app_id
      'some-app'
    end

    def enforce_api_deadlines
      false
    end

    def simulate_production_latencies
      true
    end

    private

    def tmpdir
      @tmpdir ||= begin
        # TODO: probably better idea is to make this configurable and have a railtie setup rails defaults
        if defined?(Rails)
          File.join(Rails.root, 'tmp')
        else
          require 'tmpdir'
          Dir.mktmpdir
        end
      end
    end
  end
end
