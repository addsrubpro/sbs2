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

end
