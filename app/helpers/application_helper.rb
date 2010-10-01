# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def none_on_fail
      begin
          return yield
      rescue
          return "(none entered)"
      end
  end

end
