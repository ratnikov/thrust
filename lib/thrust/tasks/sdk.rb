require 'thrust/version'

SDK_LOCATION = 'http://googleappengine.googlecode.com/files/appengine-java-sdk-1.7.1.zip'

def sdk_location
  File.basename(SDK_LOCATION, ".zip")
end

namespace :sdk do
  desc "Downloads Java SDK"
  task 'download' do
    system "mkdir -p sdk/"

    Dir.chdir('sdk') do
      zip_location = File.basename(SDK_LOCATION)

      if File.exists? zip_location
        puts "Using existing zip package..."
      else
        puts "Downloading appengine sdk from #{SDK_LOCATION}..."
        system "curl #{SDK_LOCATION} -o #{zip_location}"
      end

      unless File.exists?(zip_location)
        puts "Unpacking #{zip_location}..."
        system "unzip -qq -o #{zip_location}"
        puts "Done!"
      end
    end
  end

  desc 'Copies SDK jars to vendor'
  task 'vendor' => 'download' do
    mkdir_p jars_dir = File.join('vendor', 'appengine-java-sdk')
    mkdir_p development_jars_dir = File.join(jars_dir, 'development')

    bundled_jars = Dir.glob('sdk/appengine-java-sdk*/lib/impl/**/*.jar')

    bundled_jars.select { |jar| Thrust::Jars::PRODUCTION_JARS.include? File.basename(jar) }.each do |jar|
      cp jar, jars_dir
    end

    bundled_jars.select { |jar| Thrust::Jars::DEVELOPMENT_JARS.include? File.basename(jar) }.each do |jar|
      cp jar, development_jars_dir
    end
  end
end
