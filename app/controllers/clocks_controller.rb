class ClocksController < ApplicationController
  before_filter :require_login
  
  # GET /clocks
  # GET /clocks.xml
  def dashboard
 
    @clocks = Clock.find(:all, :order => 'created_at desc, id', :conditions => "in_out = 0", :limit=>50)
    @clock_days = @clocks.group_by { |t| t.created_at.beginning_of_day }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clocks }
    end
  end

  def mytimesheet
  
    @clocks = Clock.find(:all, :order => 'created_at desc, id', :conditions =>
        "in_out = 0 and  user_id = " + current_user.id.to_s, :limit=>50)
    @clock_days = @clocks.group_by { |t| t.created_at.beginning_of_day }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clocks }
    end
  end

  # GET /clocks/1
  # GET /clocks/1.xml
  def show
    @clock = Clock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clock }
    end
  end

  # GET /clocks/new
  # GET /clocks/new.xml
  def new
    @clock = Clock.new
    @exist = Clock.where('user_id = ? and DATE(created_at) = DATE(?) and in_out = 0', current_user.id, Date.today)

   if current_user.checkin?
     @clock.in_out = 1 #1 = check out, 0 = check in
   else
     @clock.in_out = 0
   end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clock }
    end
  end

  # GET /clocks/1/edit
  def edit
    @clock = Clock.find(params[:id])
  end

  # POST /clocks
  # POST /clocks.xml
  def create
    @clock = Clock.new(params[:clock])
    @clock.user_id = current_user.id
    if current_user.checkin?
     @clock.in_out = 1 #1 = check out, 0 = check in

   else
     @clock.in_out = 0
   end

    respond_to do |format|
      if @clock.save
        if UserMailer.checkin(@clock).deliver
        format.html { redirect_to(mytimesheet_path, :notice => 'Saved successfully.') }
        format.xml  { render :xml => @clock, :status => :created, :location => @clock }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clocks/1
  # PUT /clocks/1.xml
  def update
    @clock = Clock.find(params[:id])

    respond_to do |format|
      if @clock.update_attributes(params[:clock])
        format.html { redirect_to(@clock, :notice => 'Clock was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clocks/1
  # DELETE /clocks/1.xml
  def destroy
    @clock = Clock.find(params[:id])
    @clock.destroy

    respond_to do |format|
      format.html { redirect_to(clocks_url) }
      format.xml  { head :ok }
    end
  end

  
end
