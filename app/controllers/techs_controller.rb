class TechsController < ApplicationController

  get '/techs' do
    if logged_in?
      @techs = Tech.all
      erb :'techs/techs'
    else
      redirect '/login'
    end
  end

  get '/techs/new' do
    if logged_in?
      erb :'/techs/new'
    else
      redirect '/login'
    end
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

  post'/techs' do
    if logged_in?
      if params[:tech][:title].empty? && params[:tech][:description].empty?
        redirect "/techs/new"
      else
        @user = User.find_by(id: session[:user_id])
        @tech = Tech.create(title: params[:title], description: params[:description], user_id: @user.id)
        redirect to "/techs"
      end
     else
      redirect '/login'
     end
  end

  patch '/techs/:id' do
    if logged_in?
      if params[:tech][:title].empty? && params[:tech][:description].empty?
        redirect "/techs/#{params[:id]}/edit"
      else
        @tech = Tech.find_by_id(params[:id])
        if @tech && @tech.user = current_user
          if @tech.update(:title => params[:title], :description => params[:description])
            redirect to "/techs/#{@tech.id}"
          else
          redirect to "/techs/#{@tech.id}/edit"
          end
        else
          redirect to '/techs'
        end
      end
    else
      redirect '/login'
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
