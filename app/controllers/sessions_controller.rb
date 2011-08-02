class SessionsController < ApplicationController
  def new
    if current_user
        redirect_to :controller=>'clocks', :action=>'dashboard'
    end
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :controller=>'clocks',:action=>'new', :notice => "Logged in!"
    else
      redirect_to :controller=>'sessions',:action=>'new', :notice => "Wrong username or password!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
