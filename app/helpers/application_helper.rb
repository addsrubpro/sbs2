# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def none_on_fail
      begin
          return yield
      rescue
          return "(none entered)"
      end
  end

  def no_account_on_fail
      begin
          return yield
      rescue
          return "(no account)"
      end
  end

end
