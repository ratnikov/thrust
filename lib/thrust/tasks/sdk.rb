SDK_LOCATION = 'http://googleappengine.googlecode.com/files/appengine-java-sdk-1.7.1.zip'

def sdk_location
  File.basename(SDK_LOCATION, ".zip")
end

desc "Downloads Java SDK"
task 'download-sdk' do
  system "mkdir -p sdk/"

  Dir.chdir('sdk') do
    zip_location = File.basename(SDK_LOCATION)

    if File.exists? zip_location
      puts "Using existing zip package..."
    else
      puts "Downloading appengine sdk from #{SDK_LOCATION}..."
      system "curl #{SDK_LOCATION} -o #{zip_location}"
    end

    puts "Unpacking #{zip_location}..."
    system "unzip -qq -o #{zip_location}"
    puts "Done!"
  end
end

desc 'Copies SDK jars to vendor'
task 'vendor-sdk' => 'download-sdk' do
  vendor_dir = File.join('vendor', 'appengine-java-sdk')
  FileUtils.mkdir_p vendor_dir unless File.exists?(vendor_dir)

  Dir.glob('sdk/appengine-java-sdk*/lib/impl/**/*.jar').each do |jar|
    puts "Copying #{jar} to #{vendor_dir}..."
    FileUtils.cp jar, vendor_dir
  end
end
