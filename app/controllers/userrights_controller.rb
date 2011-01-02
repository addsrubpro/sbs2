class UserrightsController < ApplicationController
  # GET /userrights
  # GET /userrights.xml
  def index
    unless (params[:party_id].nil? || params[:party_id] == 0) 
      $party_id = params[:party_id]
    end
    @userrights = Userright.find(:all, :conditions => ["party_id = ?", $party_id])
    
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
    $party_id = params[:party_id]
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    @userright = Userright.new

    # dropdown box should contain only not yet assigned rights
    @right_for_user = Userright.find(:all, :conditions => ["party_id = ?", $party_id], :select => "right_id")
    @right_id_for_user = Array.new << 0
    @length = @right_for_user.length
    
    (1..@length).each do |a|
      @right_id_for_user << @right_for_user[a-1].right_id
    end
    
    @rights = Right.find(:all, :conditions => ["id NOT IN (?)", @right_id_for_user] )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userright }
    end
  end

  # GET /userrights/1/edit
  def edit
    @userright = Userright.find(params[:id])
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
    @userright = Userright.find(params[:id])

    respond_to do |format|
      if @userright.update_attributes(params[:userright])
        format.html { redirect_to(@userright, :notice => 'Userright was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userright.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userrights/1
  # DELETE /userrights/1.xml
  def destroy
    @userright = Userright.find(params[:id])
    @userright.destroy

    respond_to do |format|
      format.html { redirect_to(userrights_url) }
      format.xml  { head :ok }
    end
  end
end
