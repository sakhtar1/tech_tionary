require 'pry'
require 'rack-flash'

class WordsController < ApplicationController

  use Rack::Flash

  get '/words' do
    redirect_if_not_logged_in
    @user = User.find_by(id: session[:user_id])
    @words = Word.all
    erb :'words/words'
  end

  get '/words/new' do
    redirect_if_not_logged_in
    erb :'words/new'
  end


 post "/words" do
   redirect_if_not_logged_in
   if params[:title]=="" && params[:description]==""
     redirect "words/new?error=invalid title or description"
   end
   @user = User.find_by(id: session[:user_id])
   @word = Word.create(title: params[:title], description: params[:description], user_id: @user.id )
     flash[:message] = "Successfully created Tech-Word!"
   redirect "/words/#{@word.id}"
 end

  get '/words/:id' do
    redirect_if_not_logged_in
    @word = Word.find_by_id(params[:id])
    if @word && @word.user == current_user
      erb :'words/show_word'
    end
  end

  get '/words/:id/edit' do
    redirect_if_not_logged_in
    @word = Word.find_by_id(params[:id])
    if @word && @word.user == current_user
      erb :'words/edit'
    else
      redirect '/words'
    end
  end

  patch '/words/:id' do
    redirect_if_not_logged_in
    if params[:title]=="" && params[:description]==""
      redirect "/words/#{@word.id}/edit?error=invalid title or description"
    else
      @word = Word.find(params[:id])
      if @word && @word.user == current_user
        @word.update(params.select{|t|t=="title" || t=="description" || t=="user_id"})
        redirect "/words/#{@word.id}"
      else
        redirect to "/words/#{@word.id}/edit?error=invalid title or description"
      end
    end
  end

  delete '/words/:id/delete' do
    redirect_if_not_logged_in
    @word = Word.find_by_id(params[:id])
    if @word && @word.user == current_user
      @word.delete
    end
    redirect '/words'
  end

end
