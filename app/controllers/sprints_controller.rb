class SprintsController < ApplicationController
  in_place_edit_for :sprint, :title
  in_place_edit_for :sprint, :theme
  
  
  # GET /sprints
  # GET /sprints.xml
  def index
    sort =  case params[:sort]
            when "title"  then "title"
            when "theme"   then "theme"
            when "start_date" then "start_date"
            when "number_of_days" then "number_of_days"
            when "title_reverse"  then "title DESC"
            when "theme_reverse"   then "theme DESC"
            when "start_date_reverse" then "start_date DESC"
            when "number_of_days_reverse" then "number_of_days DESC"
            end
    
    @sprints = Sprint.find :all, :order => sort

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :partial => "sprints_list", :layout => false }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @sprint = Sprint.find(params[:id])
    @sort = params[:sort]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = Sprint.find(params[:id])
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = Sprint.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        flash[:notice] = 'Sprint was successfully created.'
        format.html { redirect_to(@sprint) }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        flash[:notice] = 'Sprint was successfully updated.'
        format.html { redirect_to(@sprint) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.xml
  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to(sprints_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /sprints/workload/1
  # GET /sprints/workload/1.xml
  def workload
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # workload.html.erb
      format.xml  { render :xml => @sprint }
    end
  end
  
  # GET /sprints/burndown/1
  # GET /sprints/burndown/1.json
  def burndown
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html { 
        @graph = open_flash_chart_object(800, 500, url_for( :action => 'burndown', :id => params[:id], :format => :json )) 
      }
      format.json { 
        chart = @sprint.flash_burndown
        render :text => chart, :layout => false
      }
    end
  end
  
  # PUT /sprints/update_cell/1
  # PUT /sprints/update_cell/1.xml
  def update_cell
    @cell = Cell.find(params[:id])
    @target  = params[:value]
    @cell.hours = @target
    @cell.save
    render :text => @cell.hours
  end

end
