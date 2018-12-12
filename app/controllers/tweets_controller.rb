class TweetsController < ApplicationController



  get '/tweets' do
    binding.pry
    if session.has_key?(:user_id)
      @user = User.find(session[:user_id])
      @tweets = Tweet.find_by(@user.id)
      erb :tweets
    else
      erb :'/users/error'
    end
  end

  get '/tweets/new' do
    @user = User.find(session[:user_id])

      if !@user.nil?
        erb :'/tweets/new'
      else
        erb :'/users/error'
      end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @user = User.find(session[:user_id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.create(params['tweet'])
    @tweet.user_id = @user.id
    redirect to "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end



end
