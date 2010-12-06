class PeopleController < ApplicationController
  before_filter :authenticate
  
  # GET /people
  # GET /people.xml
  def index
    @title = "People index"
    @people = Person.paginate(:page => params[:page], :per_page => 4, :order => "party_id ASC")
                              #(:order => "party_id ASC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    unless ("#{params[:party_id]}".empty? || "#{params[:party_id]}".nil? || "#{params[:party_id]}" == 0) 
      $party_id = "#{params[:party_id]}"
    end
    @person = Person.find($party_id)
    @partyroles = Partyrole.find(:all, :conditions => ["party_id = ?", $party_id])
    @title = @person.current_first_name + ' ' + @person.current_last_name
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new
    @incomeclass = Incomeclassification.find(:all)
    @occupationclass = Occupationclassification.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    @incomeclass = Incomeclassification.find(:all)
    @occupationclass = Occupationclassification.find(:all)
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])
    @person.party_id = Party.create[:id]
    $party_id = @person.party_id

    respond_to do |format|
      if @person.save
        flash[:success] = "Person was successfully created."
        format.html { redirect_to @person }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:success] = "Person was successfully updated."
        format.html { redirect_to @person }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
end
