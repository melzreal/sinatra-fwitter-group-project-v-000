class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id] == @user.id
      erb :'tweets/tweets'
    else
      erb :'users/error'
    end
  end


  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params['tweet'])
    redirect to "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end



end
