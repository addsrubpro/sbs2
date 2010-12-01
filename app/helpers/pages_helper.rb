module PagesHelper
  
  # Helper for actions selection with dropdown box in the _header.html.erb (see also pages_controller.rb)
  def select_view_options_tags
    options = PagesController::SELECTABLE_ACTIONS.map do |action|
      [action.to_s.humanize, action]
    end
    options_for_select options
  end
  
end
