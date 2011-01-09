class UserrightsController < ApplicationController
  # GET /userrights
  # GET /userrights.xml
  def index
    $user_id = params[:user_id]
    @userrights = Userright.find_all_by_user_id(params[:user_id])
    
    unless !( @userrights.nil? || @userrights.empty? )
      flash.now[:notice] = "No user right has been assigned yet!"
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userrights }
    end
  end

  # GET /userrights/1
  # GET /userrights/1.xml
  def show
    @userright = Userright.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userright }
    end
  end

  # GET /userrights/new
  # GET /userrights/new.xml
  def new
    @user = User.find(params[:user_id])
    @userright = Userright.new

    # dropdown box shall contain only not yet assigned rights
    right_for_user = Userright.find(:all, :conditions => ["user_id = ?", params[:user_id]], :select => "right_id")
    right_id_for_user = Array.new << 0
    length = right_for_user.length
    
    (1..length).each do |a|
      right_id_for_user << right_for_user[a-1].right_id
    end
    
    @rights = Right.find(:all, :conditions => ["id NOT IN (?)", right_id_for_user] )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userright }
    end
  end

  # GET /userrights/1/edit
  def edit
    # there is no edit view for userright objects    
  end

  # POST /userrights
  # POST /userrights.xml
  def create
    @userright = Userright.new(params[:userright])

    respond_to do |format|
      if @userright.save
        flash[:success] = "Userright was successfully assigned."
        
        format.html { redirect_to @userright }
        format.xml  { render :xml => @userright, :status => :created, :location => @userright }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userright.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userrights/1
  # PUT /userrights/1.xml
  def update
    # update is not provided for userright objects (destroy and create a new object)  
  end

  # DELETE /userrights/1
  # DELETE /userrights/1.xml
  def destroy
    @userright = Userright.find(params[:id])
    
    respond_to do |format|
      if @userright.destroy
        flash[:success] = "User right record was successfully destroyed."
        format.html { redirect_to userrights_path(:user_id => @userright.user_id) }
      else
        flash[:error] = "User right record could not be destroyed."
        format.html { redirect_to @userrights }
      end
    end      
  end
end
