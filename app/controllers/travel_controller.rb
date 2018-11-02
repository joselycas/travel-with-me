class TravelController < ApplicationController

  get '/travels' do
    if logged_in?
      @travels = Travel.all
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




#  patch '/travels/:id' do
#   if logged_in?
#     @travel = Travel.find(params[:id])
#     #@travel.has_required_fields?
#     #if @travel.has_required_fields?
#   if @travel.user_id == current_user.id && params[:location] != "" && params[:activity] != "" && params[:date] != ""
#      @travel.update(:location => params[:location], :activity => params[:activity], :travel_date => params[:travel_date])
#      redirect to "/travels/#{@travel.id}"
#    else
#      erb :'/travels/error'
#   end
#  end
# end
