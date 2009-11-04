class TasksController < ApplicationController
  in_place_edit_for :sprint, :title
  in_place_edit_for :sprint, :started
  in_place_edit_for :sprint, :found
  
  # GET /tasks
  # GET /tasks.xml
  def index
    sort =  case params[:sort]
            when "title"  then "title"
            when "started"   then "started"
            when "done" then "done"
            when "initial_estimate" then "initial_estimate"
            when "title_reverse"  then "title DESC"
            when "started_reverse"   then "started DESC"
            when "done_reverse" then "done DESC"
            when "initial_estimate_reverse" then "initial_estimate DESC"
            else "title"
            end
            
    @tasks = Task.all :order => sort

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :partial => "tasks_list", :layout => false }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @sprint = Sprint.find(@task.sprint_id)
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    @sprint = Sprint.find(@task.sprint_id)

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    @sprint = Sprint.find(@task.sprint_id)

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
