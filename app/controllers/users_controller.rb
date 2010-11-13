class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    unless ("#{params[:party_id]}".empty? || "#{params[:party_id]}".nil? || "#{params[:party_id]}" == 0) 
      $party_id = "#{params[:party_id]}"
    end
    @users = User.find(:all, :conditions => ["party_id = ?", $party_id])
    @user = User.find(:first, :conditions => ["party_id = ?", $party_id])
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    $party_id = "#{params[:party_id]}"
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    @user = User.new
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
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
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
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
