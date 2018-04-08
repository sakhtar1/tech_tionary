class TechsController < ApplicationController

  get '/techs' do
    redirect_if_not_logged_in
    @techs = Tech.all
    erb :'/techs/techs'
  end

  get '/techs/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'techs/new'
  end


 post "/techs" do
   redirect_if_not_logged_in
   if params[:title]=="" && params[:description]==""
     redirect "techs/new?error=invalid title or description"
   end
   Tech.create(params)
   redirect "/techs"
 end

  get '/techs/:id' do
    if logged_in?
      @tech = Tech.find_by_id(params[:id])
      erb :'techs/show_word'
    else
      redirect '/login'
    end
  end

  get '/techs/:id/edit' do
    if logged_in?
      @tech = Tech.find_by_id(params[:id])
      if @tech && @tech.user == current_user
        erb :'techs/edit'
      else
        redirect '/techs'
      end
    else
      redirect '/login'
    end
  end

  patch '/techs/:id' do
    redirect_if_not_logged_in
    if params[:title]=="" && params[:description]==""
      redirect "/techs/#{@tech.id}/edit?error=invalid title or description"
    else
      @tech = Tech.find(params[:id])
      @tech.update(params.select{|t|t=="title" || t=="description" || t=="user_id"})
      redirect "/techs/#{@tech.id}"
    end
  end

  delete '/techs/:id/delete' do
    if logged_in?
      @tech = Tech.find_by_id(params[:id])
      if @tech && @tech.user == current_user
        @tech.delete
      end
      redirect '/techs'
    else
      redirect '/login'
    end
  end

end
