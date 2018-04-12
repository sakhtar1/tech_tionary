require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
     set :views, "app/views"
     enable :sessions
     set :session_secret, "secret"
   end

   get '/' do
    erb :index
  end

 helpers do

   def redirect_if_not_logged_in
     if !logged_in?
       redirect "/login?error=You have to be logged in to do that"
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
