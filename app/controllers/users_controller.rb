class UsersController < ApplicationController

  get '/users/:id' do
    @user = User.find_by(id: session[:user_id])
    erb :'users/word_account'
  end

  get "/signup" do
    if !logged_in?
	     erb :"users/signup"
    else
      redirect '/words'
    end
	end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect "/signup?error=please fill out all edit fields"
    else
      @user = User.create(:username => params[:username], :email => params[:email],:password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/words"
    end
  end

  get "/login" do
    if !logged_in?
	      erb :"users/login"
    else
      redirect '/words'
    end
	end

  post "/login" do
   @user = User.find_by(:username => params[:username])
   if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
      redirect "/words"
   else
      redirect "/signup"
   end
  end

  get "/logout" do
    if logged_in?
  	session.clear
    #session.destroy << for CRUD delete
  	redirect "/login"
    else
      redirect "/"
    end
   end

end
