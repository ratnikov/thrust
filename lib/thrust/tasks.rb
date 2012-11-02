require 'rake'

require 'thrust/constants'

module Thrust
  module Tasks
    extend self

    def run_development_server(war_location)
      ENV['RUBYOPT'] = ENV['RUBYOPT'].gsub '-rbundler/setup', '' unless ENV['RUBYOPT'].empty?

      # doing exec, since the server blocks further execution anyway
      exec "sh #{sdk_location}/bin/dev_appserver.sh #{war_location}"
    end

    def push_deploy(war_location)
      system "#{sdk_location}/bin/appcfg.sh --enable_jar_splitting update #{war_location}"
    end

    def sdk_location
      File.join 'sdk', File.basename(::Thrust::Constants::APPENGINE_JAVA_SDK_URL, '.zip')
    end
  end
end

desc 'Installs thrust by downloading appengine java SDK to sdk/'
task 'thrust' do
  mkdir 'sdk' unless File.exists?('sdk')

  Dir.chdir('sdk') do
    sdk_url = ::Thrust::Constants::APPENGINE_JAVA_SDK_URL

    zipfile = File.basename(sdk_url)

    if File.exists? zipfile
      puts 'Using existing zip package...'
    else
      puts "Downloading appengine sdk from #{sdk_url}..."
      system "curl #{sdk_url} -o #{zipfile}"
    end

    unless File.exists? File.basename(zipfile, '.zip')
      puts "Unpacking #{zipfile}..."
      system "unzip -qq -o #{zipfile}"
      puts 'Done!'
    else
      puts "Using already existing unpacked version."
    end
  end
end

namespace :thrust do
  desc 'Downloads and installs a fresh version of the SDK'
  task :reinstall do
    rm_rf 'sdk'

    thrust_task = Rake::Task['thrust']
    thrust_task.reenable
    thrust_task.invoke
  end
end
