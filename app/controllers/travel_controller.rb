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
      @travel = Travel.create(:location => params[:location], :activity => params[:activity], :date => params[:date])
      redirect to '/travels'
    else
      redirect to '/travels/new'
    end
  end

  get '/travels/:id/edit' do
    if logged_in?
      @travel = Travel.find_by(params[:id])
      if @travel.user_id = current_user.id
      erb :'/travels/edit'
    else
      redirect to '/login'
    end
    end
  end
end
