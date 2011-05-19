module Thrust
  module Authentication
    import com.google.appengine.api.users.UserServiceFactory;

    def self.included(controller)
      controller.helper_method :logged_in?
    end

    private

    def logged_in?
      service.isUserLoggedIn
    end

    def service
      puts UserServiceFactory.inspect
      @service ||= UserServiceFactory.getUserService


      puts @service.inspect

      @service
    end
  end
end
