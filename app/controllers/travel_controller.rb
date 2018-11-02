class TravelController < ApplicationController

  get '/travels' do
    authorize_user
    @travels = Travel.all
    erb :'/travels/show'
  end

  get '/travels/new' do
   authorize_user
   erb :'/travels/new'
  end

  post '/travels' do
    authorize_user
      if params[:location] != "" && params[:activity] != "" && params[:date] != ""
        @travel = current_user.travels.create(:location => params[:location], :activity => params[:activity], :travel_date => params[:travel_date])
        redirect to "/travels/#{@travel.id}"
    else
        redirect to '/travels/new'
    end
  end

  get '/travels/:id' do
   authorize_user
   @travel = Travel.find(params[:id])
    if @travel.user_id == current_user.id
      erb :'/travels/travel'
    else
      redirect to "/travels"
    end
  end

  get '/travels/:id/edit' do
    authorize_user
    @travel = Travel.find(params[:id])
     if @travel.user_id == current_user.id
      erb :'/travels/edit'
     else
      redirect to "/travels"
     end
  end

  patch '/travels/:id' do
    authorize_user
    @travel = Travel.find(params[:id])
    redirect to "/travels" if @travel.user_id != current_user.id
      if params[:location] != "" && params[:activity] != "" && params[:date] != ""
          @travel.update(:location => params[:location], :activity => params[:activity], :travel_date => params[:travel_date])
          redirect to "/travels/#{@travel.id}"
        else
          redirect to "/travels/#{@travel.id}/edit"
      end
    end
  end

  delete '/travels/:id/delete' do
   authorize_user
   @travel = Travel.find(params[:id])
    if @travel.user_id == current_user.id
      @travel.delete
      erb :'/travels/delete'
    else
      "/travels/#{@travel.id}"
    end
end
