module PagesHelper
  
  # Helper for actions selection with dropdown box in the _actionsbox.html.erb (define selectable actions in: pages_controller.rb)
  def select_view_options_tags
    if !signed_in?
      options = PagesController::SELECTABLE_ACTIONS.map do |action|
        [action.to_s.humanize, action]
      end
     
    elsif admin_user?      
      options = PagesController::SELECTABLE_ACTIONS_ADMIN.map do |action|
        [action.to_s.humanize, action]
      end
      
    else
      options = PagesController::SELECTABLE_ACTIONS_STD.map do |action|
        [action.to_s.humanize, action]
      end
  
    end  
    options_for_select options
  end
  
end
