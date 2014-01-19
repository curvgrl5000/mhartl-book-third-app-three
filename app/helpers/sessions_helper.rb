module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token  # remember, that 'permanent' method was created because it got so popular.
                                                              # since one could set a date in the future, we began seeing how tokens were
                                                              # implemented and used. It sets an expiration date 20 years into the future
    self.current_user = user    # this is un necessary due to the immediate redirect in the create action in the SessionsController
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)  # This established how current_user is first called and identifyied frrom the datatbase
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # will be called at least once every time a user visits a page on the site, 
    # While 'find_by_remember_token' method will take the first time 'current_user' attribute for subsequent invocations, withought hitting the database
  end
end
