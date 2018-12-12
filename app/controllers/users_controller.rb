class UsersController < ApplicationController

  get '/index' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty?
      erb :'/users/error'
     else
       @user = User.create(params[:user])
       session[:user_id] = @user.id
       redirect '/tweets'
     end

  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username], password: params[:user][:password])
    if !@user.nil?
      session[:user_id] = @user.id
      redirect '/users/home'
    end
     redirect '/tweets'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    @tweets = Tweet.find_by(@user.id)
    erb :'/users/show'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end
