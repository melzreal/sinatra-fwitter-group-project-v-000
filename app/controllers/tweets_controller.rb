class TweetsController < ApplicationController



  get '/tweets' do
    if session.has_key?(:user_id)

      @user = User.find(session[:user_id])
      @tweet = Tweet.all.each do |t|
        t.user_id == @user.id
      end
      erb :tweets
    else
      erb :'/users/error'
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

  post '/tweets' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.create(params['tweet'])
    @tweet.user_id = @user.id
    redirect to "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
      if User.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:tweet]).save
        redirect to "/tweets"
     else
        redirect '/login'
     end
  end

  delete '/tweet/:id' do
    if User.is_logged_in?(session)
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.delete
     redirect to '/tweets'
    else
     redirect '/login'
    end
   end


end
