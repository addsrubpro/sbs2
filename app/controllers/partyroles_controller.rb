class PartyrolesController < ApplicationController
  before_filter :authenticate
  
  # GET /partyroles
  # GET /partyroles.xml
  def index
    unless (params[:party_id].nil? || params[:party_id] == 0) 
      $party_id = params[:party_id]
    end
    @partyroles = Partyrole.find(:all, :conditions => ["party_id = ?", $party_id])
    @partyrole = Person.find(:first, :conditions => ["party_id = ?", $party_id])
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    
    unless !( @partyroles.nil? || @partyroles.empty? )
      flash.now[:notice] = "No party role has been assigned yet!"
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @partyroles }
    end
  end

  # GET /partyroles/1
  # GET /partyroles/1.xml
  def show
    @partyroles = Partyrole.find(:all, :conditions => ["party_id = ?", $party_id])
    @partyrole = Person.find(:first, :conditions => ["party_id = ?", $party_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @partyrole }
    end
  end

  # GET /partyroles/new
  # GET /partyroles/new.xml
  def new
    $party_id = params[:party_id]
    @person = Person.find(:first, :conditions => ["party_id = ?", $party_id], :select => "party_id, current_last_name, current_first_name")
    @partyrole = Partyrole.new
    
    # dropdown box should contain only not yet assigned roles
    @role_for_party = Partyrole.find(:all, :conditions => ["party_id = ?", $party_id], :select => "role_id")
    @role_id_for_party = Array.new << 0
    @length = @role_for_party.length
    
    (1..@length).each do |a|
      @role_id_for_party << @role_for_party[a-1].role_id
    end
    
    @roles = Role.find(:all, :conditions => ["id NOT IN (?)", @role_id_for_party] )
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @partyrole }
    end
  end

  # GET /partyroles/1/edit
  def edit
    # this action is not provided for partyroles
  end

  # POST /partyroles
  # POST /partyroles.xml
  def create
    @partyrole = Partyrole.new(params[:partyrole])
    
    respond_to do |format|
      if @partyrole.save
        flash[:success] = "Party role was successfully assigned."
        format.html { redirect_to(@partyrole) }
        format.xml  { render :xml => @partyrole, :status => :created, :location => @partyrole }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @partyrole.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /partyroles/1
  # PUT /partyroles/1.xml
  def update
    # this action is not provided for partyroles
  end

  # DELETE /partyroles/1
  # DELETE /partyroles/1.xml
  def destroy
    @partyrole = Partyrole.find(params[:id])
    @partyrole.destroy

    respond_to do |format|
      format.html { redirect_to(partyroles_url) }
      format.xml  { head :ok }
    end
  end
end
