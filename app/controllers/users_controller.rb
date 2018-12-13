class UsersController < ApplicationController


  get '/signup' do
    session.clear
    if session[:user_id] != nil
      redirect '/tweets'
    else
     erb :'users/create_user'
    end
  end

  post '/signup' do

    if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty?
      redirect '/signup'
     else
       @user = User.create(params[:user])
       @user.save
       session[:user_id] = @user.id
       redirect '/tweets'
     end
  end

  get '/login' do

    if session[:user_id] != nil
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end


  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if !@user.nil? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      erb :'/users/error'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if User.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
