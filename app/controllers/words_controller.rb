require 'pry'
class WordsController < ApplicationController

  get '/words' do
    redirect_if_not_logged_in
    @words = Word.all

    erb :'/words/words'
  end

  get '/words/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'words/new'
  end


 post "/words" do
   redirect_if_not_logged_in
   if params[:title]=="" && params[:description]==""
     redirect "words/new?error=invalid title or description"
   end
   Word.create(title: params[:title], description: params[:description])
   redirect "/words"
 end

  get '/words/:id' do
    if logged_in?
      @word = Word.find_by_id(params[:id])
      erb :'words/show_word'
    else
      redirect '/login'
    end
  end

  get '/words/:id/edit' do
    if logged_in?
      @word = Word.find_by_id(params[:id])
      binding.pry
      if @word && @word.user == current_user
        erb :'words/edit'
      else
        redirect '/words'
      end
    else
      redirect '/login'
    end
  end

  patch '/words/:id' do
    redirect_if_not_logged_in
    if params[:title]=="" && params[:description]==""
      redirect "/words/#{@word.id}/edit?error=invalid title or description"
    else
      @word = Word.find(params[:id])
      @word.update(params.select{|t|t=="title" || t=="description" || t=="user_id"})
      redirect "/words/#{@word.id}"
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
