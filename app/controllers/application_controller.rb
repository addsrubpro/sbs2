# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all               # include all helpers in all views
  include SessionsHelper    # include the SessionsHelper in all controllers
  include ApplicationHelper # include the ApplicationHelper in all controllers
  protect_from_forgery      # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
end
