require 'bundler/setup'

require 'rspec'

Dir['spec/support/**/*'].each { |support_file| require support_file }

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'vendor')

require 'thrust'
require 'thrust/development'

RSpec.configure do |config|
  # enable thrust environment except for :thrust => false examples
  config.around do |example| 
    unless example.metadata[:engage_thrust] == false
      Thrust::Development.engaged { example.run }
    else
      example.run
    end
  end
end
