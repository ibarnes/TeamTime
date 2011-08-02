class UsersController < ApplicationController
 
 # GET /tasks
  # GET /tasks.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end


def new
  

  @user = User.new
  render :layout => 'signup'

end

def create
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
     redirect_to :controller=>'clocks',:action=>'new', :notice => "Logged in!"
    #redirect_to :controller=>'sessions' ,:action=>'new', :notice => "Signed up now sign in!"
  else
    render "new"
  end
end

def edit
  @user = User.find(params[:id])
end

 # PUT /user/1
  # PUT /user/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
