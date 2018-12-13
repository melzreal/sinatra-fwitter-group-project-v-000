class UsersController < ApplicationController

  get '/index' do
    erb :index
  end

  get '/signup' do
    if session[:user_id] != nil
      redirect '/tweets'
    else
     erb :'users/create_user'
    end
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
      redirect '/tweets'
    else
      erb :'/users/error'
    end
  end


  get '/users/home' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.all.each do |t|
      t.user_id == @user.id
    end

    erb :'/users/show'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
