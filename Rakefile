require 'rspec/core/rake_task'

require 'thrust/tasks'

desc 'Copies SDK jars to vendor'
task 'vendor-sdk' => 'thrust' do
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


RSpec::Core::RakeTask.new(:spec => 'vendor-sdk')

task :default => :spec
