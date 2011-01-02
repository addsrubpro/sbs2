class IncomeclassificationsController < ApplicationController
  before_filter :authenticate
  
  # GET /incomeclassifications
  # GET /incomeclassifications.xml
  def index
    @title = "Income classifications"
    @incomeclassifications = Incomeclassification.paginate(:page => params[:page], :per_page => 4,:order => "id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @incomeclassifications }
    end
  end

  # GET /incomeclassifications/1
  # GET /incomeclassifications/1.xml
  def show
    @incomeclassification = Incomeclassification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @incomeclassification }
    end
  end

  # GET /incomeclassifications/new
  # GET /incomeclassifications/new.xml
  def new
    @title = "New income classification"
    @incomeclassification = Incomeclassification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @incomeclassification }
    end
  end

  # GET /incomeclassifications/1/edit
  def edit
    @incomeclassification = Incomeclassification.find(params[:id])
  end

  # POST /incomeclassifications
  # POST /incomeclassifications.xml
  def create
    @incomeclassification = Incomeclassification.new(params[:incomeclassification])

    respond_to do |format|
      if @incomeclassification.save
        flash[:success] = "Income classification was successfully created."
        format.html { redirect_to @incomeclassification }
        format.xml  { render :xml => @incomeclassification, :status => :created, :location => @incomeclassification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @incomeclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /incomeclassifications/1
  # PUT /incomeclassifications/1.xml
  def update
    @incomeclassification = Incomeclassification.find(params[:id])

    respond_to do |format|
      if @incomeclassification.update_attributes(params[:incomeclassification])
        flash[:success] = "Income classification was successfully updated."
        format.html { redirect_to @incomeclassification }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @incomeclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /incomeclassifications/1
  # DELETE /incomeclassifications/1.xml
  def destroy
    @incomeclassification = Incomeclassification.find(params[:id])
    @incomeclassification.destroy

    respond_to do |format|
      format.html { redirect_to incomeclassifications_url }
      format.xml  { head :ok }
    end
  end
end
