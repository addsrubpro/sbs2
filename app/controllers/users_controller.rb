class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user , :only => :destroy
  before_filter :correct_user, :only => [:show, :edit, :update]
  
  # GET /users
  # GET /users.xml
  def index
    @title ="Listing user accounts"
    if !params[:user_id].nil? 
      @users = User.paginate(:page => params[:page], :conditions => ['id = ?', params[:user_id]])     # to find only the one user record with the provided :user_id
    else
      @users = User.paginate(:page => params[:page], :order => 'party_id ASC', :per_page => 3)        # to find all user records
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def users_search_form
    @title = "User accounts search form"
    render "users_search_form"
  end
  
  def basic_search
    @title = "User accounts: basic search results"
    if user = User.find_by_username(params[:username])      # to find 0 or 1 user (exact username is required)
      redirect_to :action => "index", :user_id => user.id  # search.html.erb   <-- search results page
    else
      flash.now[:notice] = "No user account has been found. Please try again."
      render "users_search_form"
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @tilte = "Show user account"
    @user = User.find(params[:id])
    
    unless @user.userrights.any?
      flash.now[:notice] = "No user right has been asigned yet."
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = "New user account"
    $party_id = params[:party_id]
    @person = Person.find_by_party_id($party_id, :select => "party_id, current_last_name, current_first_name")
    @user = User.new
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit user account"
    #@user = User.find(params[:id])  # to find the user is already done by: before_filter :correct_user
  end

  # POST /users
  # POST /users.xml
  def create
    @person = Person.find_by_party_id($party_id, :select => "party_id, current_last_name, current_first_name")  # is necessary in the case of multiple calls for this method - this is the case if user could not be saved (e.g. password to short etc.)
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = "User was successfully created."
        format.html { redirect_to @user }  # show.html.erb
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #@user = User.find(params[:id])  # to find the user is already done by: before_filter :correct_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = "User was successfully updated."
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        @title = "Edit user account"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.destroy
        flash[:success] = "User record was successfully destroyed."
        format.html { redirect_to people_path(:party_id => @user.party_id) }
      else
        flash[:error] = "User record could not be destroyed."
        format.html { redirect_to users_path(:user_id => params[:id]) }
      end
    end   
  end
end
