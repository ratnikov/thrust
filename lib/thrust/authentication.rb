module Thrust
  module Authentication
    import com.google.appengine.api.users.UserServiceFactory;

    def logged_in?
      service.isUserLoggedIn
    end

    def service
      @service ||= UserServiceFactory.getUserService

      @service
    end
  end
end
