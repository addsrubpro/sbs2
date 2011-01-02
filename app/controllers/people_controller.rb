class PeopleController < ApplicationController
  before_filter :authenticate
  
  AGE = { "0" => 0, "18" => 18, "25" => 25, "35" => 35, "55" => 55, "65" => 65, "unlimited" => 200 }.sort
    
  # GET /people
  # GET /people.xml
  def index
    @title = "People index"
    @people = Person.paginate(:page => params[:page], :per_page => 4, :order => "party_id ASC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end
  
  def search_form
    @title = "Search form"
    @incomeclass = Incomeclassification.find(:all)
    @occupationclass = Occupationclassification.find(:all, :order => 'description ASC')
    
    render "search_form"
    
  end
  
  def search
    @title = "People search result"
    
    if !params[:party_id].empty?
      sql_insert_pid = ' AND party_id = :pid'
    else
      sql_insert_pid = ''
    end
        
    @people = Person.paginate(:page => params[:page], :per_page => 10,
                              :conditions => ['current_last_name LIKE :cln AND
                                               current_first_name LIKE :cfn' + sql_insert_pid,
                                               {:cln => params[:current_last_name].to_s+"%",
                                               :cfn => params[:current_first_name].to_s+"%",
                                               :pid => params[:party_id]} ])
                                               # the % sign is the SQL LIKE wildcard which is added to search strings with type VARCHAR delivered by the relevant params (does not work with INTEGER attributes on PostgreSQL DB)
    if !params[:party_id].empty? 
      @was_selected = "Selected Party ID: " + params[:party_id]
    else
      @was_selected = "Party ID not selected."
    end
    
    respond_to do |format|
      format.html # search.html.erb   <-- search results page
      format.xml  { render :xml => @people }
    end
  end
  
  def search_classi
    @title = "Search form incomeclassification"
    birthdate_low = Date.today - params[:age_high][:key].to_i.years
    birthdate_high = Date.today - params[:age_low][:key].to_i.years
        
    if !params[:person][:incomeclassification_id].empty?
      ic_description = Incomeclassification.find(params[:person][:incomeclassification_id]).description
      sql_insert_ic = "p.incomeclassification_id = :ic_id AND "
    else
      ic_description = "not selected"
      sql_insert_ic = ""
    end
    
    if !params[:person][:occupationclassification_id].empty?
      oc_description = Occupationclassification.find(params[:person][:occupationclassification_id]).description
      sql_insert_oc = "p.occupationclassification_id = :oc_id AND "
    else
      oc_description = "not selected"
      sql_insert_oc = ""
    end
    
    sql_query = "SELECT * FROM people p WHERE " + sql_insert_ic + sql_insert_oc + "p.birth_date BETWEEN :bdl AND :bdh"
    @people = Person.find_by_sql [sql_query, {:ic_id => params[:person][:incomeclassification_id], :oc_id => params[:person][:occupationclassification_id], :bdl => birthdate_low, :bdh => birthdate_high}]
    
    @was_selected = "<b>Birthdate</b> is between <i>#{birthdate_low}</i> and <i>#{birthdate_high}</i> AND <b>Income classification</b> is <i>#{ic_description}</i> AND <b>Occupation classification</b> is <i>#{oc_description}</i>."
    
    render "search" # search.html.erb   <-- search results page
    
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    unless (params[:party_id].nil? || params[:party_id] == 0) 
      $party_id = params[:party_id]
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
    @incomeclass = Incomeclassification.find(:all, :order => "description ASC")
    @occupationclass = Occupationclassification.find(:all, :order => "description ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    @incomeclass = Incomeclassification.find(:all, :order => "description ASC")
    @occupationclass = Occupationclassification.find(:all, :order => "description ASC")
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
