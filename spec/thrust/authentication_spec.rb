require 'spec_helper'

require 'action_controller'

class TestController < ActionController::Base
  include Thrust::Authentication
end

describe Thrust::Authentication do
  describe "#logged_in?" do
    it { TestController.new.logged_in?.should be_false }
  end
end
