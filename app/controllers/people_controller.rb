class PeopleController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => :destroy
  before_filter :people_search_advanced, :only => :search_classi
  
  AGE = { "0" => 0, "18" => 18, "25" => 25, "35" => 35, "55" => 55, "65" => 65, "unlimited" => 200 }.sort
    
  # GET /people
  # GET /people.xml
  def index
    @title = "People index"
    
    if !params[:party_id].nil? 
      @people = Person.paginate(:page => params[:page], :conditions => ['party_id = ?', params[:party_id]] )
    else
      @people = Person.paginate(:page => params[:page], :conditions => ['party_id IS NOT ?', 1], :per_page => 4, :order => "party_id ASC")
    end
    
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
  
  def search                                                # people: basic search
    @title = "People: basic search results"

    $cln = params[:current_last_name].to_s + "%" unless params[:current_last_name].nil?
    $cfn = params[:current_first_name].to_s + "%" unless params[:current_first_name].nil?   # the % sign is the SQL LIKE wildcard which is added to search strings of type VARCHAR delivered by the relevant params (does not work with INTEGER attributes on PostgreSQL DB)
   
    unless params[:party_id].nil?       # due to pagination: only the first method call provides parameters, subsequent calls (e.g. for pages 2, 3, 4 ,etc. don't provide parameters (parameters are nil)
      if params[:party_id].empty?
        $sql_insert_pid = ''
        pid_selected_param = ''
      else
        $sql_insert_pid = ' AND party_id = :pid'
        pid_selected_param = "<br />Party ID: <b> #{params[:party_id]} </b>"
      end
      flash.now[:info] = "Selected parameters: #{pid_selected_param} <br /> current last name: <b> #{$cln} </b> <br /> current first name: <b> #{$cfn} </b>"
    
      # counter for records found
      sql_count = "SELECT COUNT(*) FROM people WHERE current_last_name LIKE :cln AND current_first_name LIKE :cfn" + $sql_insert_pid
      people_counter = Person.count_by_sql [sql_count, {:cln => $cln, :cfn => $cfn, :pid => params[:party_id]}]
      
      if people_counter > 1
        flash.now[:info1] = people_counter.to_s + " records have been found."
      else
        flash.now[:info1] = people_counter.to_s + " record has been found."
      end
    end
    
    @people = Person.paginate(:page => params[:page], :per_page => 4,
                              :conditions => ['current_last_name LIKE :cln AND
                                               current_first_name LIKE :cfn' +
                                               $sql_insert_pid,
                                               {:cln => $cln,
                                                :cfn => $cfn,
                                                :pid => params[:party_id]} ])
   
    respond_to do |format|
      format.html # search.html.erb   <-- search results page
      format.xml  { render :xml => @people }
    end
  end
  
  def search_classi                               # people: advanced search
    @title = "People: advanced search results"
    
    $birthdate_low = Date.today - params[:age_high][:value].to_i.years unless params[:age_high].nil?
    $birthdate_high = Date.today - params[:age_low][:value].to_i.years unless params[:age_low].nil?
    
    unless params[:classify].nil?                                 # due to pagination: only the first method call provides parameters, subsequent calls (e.g. for pages 2, 3, 4 ,etc. don't provide parameters (parameters are nil)
      if params[:classify][:incomeclassification_id].empty?
        ic_selected_param = ""
        sql_insert_ic = ""
      else
        ic_description = Incomeclassification.find(params[:classify][:incomeclassification_id]).description
        ic_selected_param = "<br />Income classification: <b>#{ic_description}</b>"
        $ic_id = params[:classify][:incomeclassification_id]
        sql_insert_ic = "p.incomeclassification_id = :ic_id AND "
      end
      
      if params[:classify][:occupationclassification_id].empty?
        oc_selected_param = ""
        sql_insert_oc = ""
      else
        oc_description = Occupationclassification.find(params[:classify][:occupationclassification_id]).description
        oc_selected_param = "<br />Occupation classification: <b>#{oc_description}</b>"
        $oc_id = params[:classify][:occupationclassification_id]
        sql_insert_oc = "p.occupationclassification_id = :oc_id AND "
      end
      
      $sql_query = "SELECT * FROM people p WHERE " + sql_insert_ic + sql_insert_oc + "p.birth_date BETWEEN :bdl AND :bdh"
      
      # counter for records found
      sql_count = "SELECT COUNT(*) FROM people p WHERE " + sql_insert_ic + sql_insert_oc + "p.birth_date BETWEEN :bdl AND :bdh"
      
      people_counter = Person.count_by_sql [sql_count, {:ic_id => $ic_id, :oc_id => $oc_id, :bdl => $birthdate_low, :bdh => $birthdate_high}]
      
      if people_counter > 1
        flash.now[:info] = people_counter.to_s + " records have been found."
      else
        flash.now[:info] = people_counter.to_s + " record has been found."
      end
      
      flash.now[:info1] = "Selected parameters: <br />Birthdate range from: <b>#{$birthdate_low}</b> to: <b>#{$birthdate_high}</b>" + ic_selected_param + oc_selected_param
    end
      
    @people = Person.paginate_by_sql [$sql_query, {:ic_id => $ic_id, :oc_id => $oc_id, :bdl => $birthdate_low, :bdh => $birthdate_high}], :page => params[:page], :per_page => 4
    
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
    @title = @person.current_first_name.to_s + ' ' + @person.current_last_name.to_s
    
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
    @person = Person.find(params[:id])      # params[:id] contains here the 'party_id' due to the special path definition in routes.rb
   
    respond_to do |format|
      if @person.destroy
        flash[:success] = "Person record was successfully destroyed."
        format.html { redirect_to people_path }
      else
        flash[:error] = "Person record cannot be destroyed due to existing associations."
        format.html { redirect_to people_path(:party_id => params[:id]) }
      end
    end
  end
end
