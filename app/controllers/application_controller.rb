require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  configure do
     set :public_folder, 'public'
     set :views, "app/views"
     enable :sessions
     set :session_secret, "secret"
   end

   get '/' do
    erb :index
  end

 helpers do
    def not_logged_in?
      if !logged_in?
        redirect "/signup"
      end
    end
    def logged_in?
     !!current_user
    end

    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end