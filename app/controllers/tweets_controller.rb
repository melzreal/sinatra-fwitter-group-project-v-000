class TweetsController < ApplicationController


  get '/tweets' do

    if session.has_key?(:user_id)
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do

    if !params[:tweet][:content].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(params[:tweet])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/tweets'
    end
  end


  get '/tweets/:id' do

    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @tweet_maker = User.find(@tweet.user_id)
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

  get '/all' do
    erb :'/tweets/all'
  end

  patch '/tweets/:id' do

      if User.is_logged_in?(session)
          @tweet = Tweet.find(params[:id])
          if !params[:tweet][:content].empty?
            @tweet.update(content: params[:tweet][:content]) unless @tweet.user_id != session[:user_id]
            @tweet.save
            redirect to '/tweets'
          else
            redirect to '/tweets'
          end
     else
        redirect '/login'
     end
  end

  delete '/tweets/:id/delete' do
    if User.is_logged_in?(session)
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.delete unless @tweet.user_id != session[:user_id]
     redirect to '/tweets'
    else
     redirect to '/login'
    end
   end


end
