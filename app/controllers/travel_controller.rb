class TravelController < ApplicationController

  get '/travels' do
    if logged_in?
      @travels= Travel.all
      erb :'/travels/show'
    else
      redirect to "/login"
    end
  end

  get '/travels/new' do
   if logged_in?
     erb :'/travels/new'
    else
      redirect to '/login'
    end
  end

  post '/travels' do
    if logged_in? && params[:travels] != ""
      @travel = current_user.travels.create(:location => params[:location], :activity => params[:activity], :travel_date => params[:travel_date])

      redirect to "/travels/#{@travel.id}"
    else
      redirect to '/travels/new'
    end
  end

  get '/travels/:id' do
    if logged_in?
      @travel = Travel.find(params[:id])
      erb :'/travels/travel'
    else
      redirect to '/login'
    end
  end


  get '/travels/:id/edit' do
    if logged_in?
      @travel = Travel.find(params[:id])
      if @travel.user_id = current_user.id
      erb :'/travels/edit'
    else
      redirect to '/login'
     end
    end
  end

  patch '/travels/:id' do
   if logged_in?
   @travel = Travel.find(params[:id])
    if params[:location] != nil && params[:activity] != nil && params[:date] != nil
      @travel.user_id = current_user.id
      @travel.update(:location => params[:location], :activity => params[:activity], :travel_date => params[:travel_date])
      redirect to "/travels/#{@travel.id}"
    else
      redirect to '/'
    end
  end
 end

  delete '/travels/:id/delete' do
    if logged_in?
       @travel = Travel.find(params[:id])
       if @travel.user_id = current_user.id

         @travel.delete
    erb :'/travels/delete'
      else
        "/"
      end
    end
  end
end
