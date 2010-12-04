# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Return "(none entered)" if no value has been assigned.  
  def none_on_fail
      begin
          return yield
      rescue
          return "(none entered)"
      end
  end

  # Return "(no account)" if no value has been assigned.
  def no_account_on_fail
      begin
          return yield
      rescue
          return "(no account)"
      end
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Student Banking Solution"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # Helper method for "logo" variable used in header partial (_header.html.erb)
  def logo
    image_tag("SBS_logo2.png", :alt => "Student Banking Application", :class => "round")
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def deny_access
      store_location
      flash[:notice] = "Please sign in to get access."
      redirect_to signin_path
    end
    
    # methods for the 'before_filter :correct_user' (to prevent to change user data, e.g. password, from other users)
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, :notice => "You are not
                  allowed to perform this action.") unless current_user?(@user)
    end
    
    def current_user?(user)
      user == current_user
    end
    
    # methods for the friendly forwarding to the intended destination after signin in
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
end
