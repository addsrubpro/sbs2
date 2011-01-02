class PagesController < ApplicationController
  before_filter :authenticate, :only => [:income_classes, :occupation_classes, :roles, :people]

  # To define the selectable actions for the dropdown box in _actionsbox.html.erb
  SELECTABLE_ACTIONS_ADMIN = [:home, :about, :income_classes, :occupation_classes, :rights, :roles, :people, :people_search]
  SELECTABLE_ACTIONS_STD = [:home, :about, :people, :people_search]
  SELECTABLE_ACTIONS = [:sign_in, :home, :about]
  
  # Method for actions selection with dropdown box in _header.html.erb (see also pages_helper.rb)
  def select_view
    #redirect_to :action => params[:selection]
    if (SELECTABLE_ACTIONS_ADMIN.include? params[:selection].to_sym) || (SELECTABLE_ACTIONS.include? params[:selection].to_sym)
      redirect_to :action => params[:selection]
    else
      redirect_to :action => 'home'
    end
  end

  def sign_in
    @title = "Sign in"
    redirect_to signin_path
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
  
  def rights
    @title = "Right definitions"
    redirect_to :controller => 'rights'
  end
  
  def roles
    @title = "Role classifications"
    redirect_to :controller => 'roles'
  end
  
  def people
    @title = "People"
    redirect_to :controller => 'people'
  end
  
  def people_search
    @title = "People search"
    redirect_to search_form_path
  end
end
