class OccupationclassificationsController < ApplicationController
  before_filter :authenticate
  
  # GET /occupationclassifications
  # GET /occupationclassifications.xml
  def index
    @occupationclassifications = Occupationclassification.paginate(:page => params[:page], :per_page => 4, :order => "description ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @occupationclassifications }
    end
  end

  # GET /occupationclassifications/1
  # GET /occupationclassifications/1.xml
  def show
    @occupationclassification = Occupationclassification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @occupationclassification }
    end
  end

  # GET /occupationclassifications/new
  # GET /occupationclassifications/new.xml
  def new
    @occupationclassification = Occupationclassification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @occupationclassification }
    end
  end

  # GET /occupationclassifications/1/edit
  def edit
    @occupationclassification = Occupationclassification.find(params[:id])
  end

  # POST /occupationclassifications
  # POST /occupationclassifications.xml
  def create
    @occupationclassification = Occupationclassification.new(params[:occupationclassification])

    respond_to do |format|
      if @occupationclassification.save
        flash[:success] = "Occupation classification was successfully created."
        format.html { redirect_to @occupationclassification }
        format.xml  { render :xml => @occupationclassification, :status => :created, :location => @occupationclassification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @occupationclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /occupationclassifications/1
  # PUT /occupationclassifications/1.xml
  def update
    @occupationclassification = Occupationclassification.find(params[:id])

    respond_to do |format|
      if @occupationclassification.update_attributes(params[:occupationclassification])
        flash[:success] = "Occupation classification was successfully updated."
        format.html { redirect_to @occupationclassification }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @occupationclassification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /occupationclassifications/1
  # DELETE /occupationclassifications/1.xml
  def destroy
    @occupationclassification = Occupationclassification.find(params[:id])
    @occupationclassification.destroy

    respond_to do |format|
      format.html { redirect_to occupationclassifications_url }
      format.xml  { head :ok }
    end
  end
end
