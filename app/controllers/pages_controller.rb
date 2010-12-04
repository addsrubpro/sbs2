class PagesController < ApplicationController
  before_filter :authenticate, :only => [:income_classes, :occupation_classes, :roles, :people]

  # To define the selectable actions for the dropdown box in _header.html.erb
  SELECTABLE_ACTIONS = [:home, :about, :income_classes, :occupation_classes, :roles, :people]

  # Method for actions selection with dropdown box in _header.html.erb (see also pages_helper.rb)
  def select_view
    if SELECTABLE_ACTIONS.include? params[:selection].to_sym
      redirect_to :action => params[:selection]
    else
      redirect_to :action => 'default_action'
    end
  end

  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end
  
  def income_classes
    @title = "Income classifications"
    redirect_to :controller => 'incomeclassifications'
  end
  
  def occupation_classes
    @title = "Occupation classifications"
    redirect_to :controller => 'occupationclassifications'
  end
  
  def roles
    @title = "Role classifications"
    redirect_to :controller => 'roles'
  end
  
  def people
    @title = "People"
    redirect_to :controller => 'people'
  end
  
end
