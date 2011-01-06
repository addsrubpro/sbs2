class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  # GET /users
  # GET /users.xml
  def index
    unless (params[:party_id].nil? || params[:party_id] == 0) 
      $party_id = params[:party_id]
    end
    @users = User.paginate(:page => params[:page], :per_page => 4)
    @user = User.find(:first, :conditions => ["party_id = ?", $party_id])
    # @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    #@user = User.find(:id)
    @user = User.find_by_party_id(params[:party_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    $party_id = params[:party_id]
    @person = Person.find(:first, :conditions => ["party_id = ?", params[:party_id]], :select => "party_id, current_last_name, current_first_name")
    @user = User.new
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])  # to find the user is already done by: before_filter :correct_user
  end

  # POST /users
  # POST /users.xml
  def create
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = "User was successfully created."
        format.html { redirect_to :controller => "users", :action => "show", :party_id => $party_id }  # show.html.erb
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
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
