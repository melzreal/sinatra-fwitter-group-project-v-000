class TweetsController < ApplicationController


  get '/tweets' do
    if session.has_key?(:user_id)
      @user = User.find(session[:user_id])
      @tweet = Tweet.find_by_id(:user_id)
      erb :tweets
    else
      erb :'/login'
    end
  end

  post '/tweets' do
    if !params[:tweet].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(params[:tweet])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      erb :'/users/error'
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if User.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end


  patch '/tweets/:id' do
      if User.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:tweet]).save
        redirect to '/tweets'
     else
        redirect '/login'
     end
  end

  delete '/tweets/:id' do
    if User.is_logged_in?(session)
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.delete unless @tweet.user_id != session[:user_id]

     redirect to '/tweets'
    else
     redirect to '/login'
    end
   end


end
