class UserController < ApplicationController

 get '/users/:slug' do
   @user = User.find_by_slug(params[:slug])
   erb :'users/show'
 end

  get '/signup' do
    if !logged_in?
     erb :"/users/new"
   else
     redirect to '/travels'
    end

  end

  post '/signup' do
    if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:user_name => params[:user_name], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/travels'
    end
  end

    get '/login' do
      if !logged_in?
        erb :'/users/login'
      else
        redirect to '/travels'
    end
  end

  post '/login' do
    @user = User.find_by(:user_name => params[:user_name])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect to "/travels"
     else
       redirect to '/signup'
     end
   end

   get '/logout' do
     if logged_in?
       session.destroy
       redirect to '/login'
     else
       redirect to '/'
     end
   end
end
