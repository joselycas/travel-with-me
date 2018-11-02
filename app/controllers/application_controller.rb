require './config/environment'

class ApplicationController < Sinatra::Base

configure do
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions
  set :session_secret, "travel_secret"
end

  get '/' do
    erb :'home'
  end

  def logged_in?
   !!current_user
  end

  def log_in(email, password)
    @user = User.find_by(params[:email])
    if @user == @user && @user.authenticate(params[:password])
     session[:email] = @user.email
    else
      redirect to '/login'
    end
   end

   def logout
    session.clear
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   end

   def authorize_user
     if !logged_in?
       redirect to "/login"
     end
   end
  end
  #helpers do

  #

  #  def logged_in?
  #    !!current_user
  #  end
  #end
