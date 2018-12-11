class UsersController < ApplicationController


  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.find_by(email: params[:email])
     if !@user.nil?
       session[:user_id] = @user.id
       redirect '/users/home'
     end
       redirect '/users/login'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if !@user.nil?
      session[:user_id] = @user.id
      redirect '/users/home'
    end
     redirect '/users/login'
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


end
