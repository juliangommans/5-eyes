enable :sessions

get '/' do
  #homepage
  erb :index
end

get '/login' do
  @wall_of_blinks = Blink.all
  # show logged in page
  erb :login
end

get '/sign_up' do
  #stuff for signing up
  erb :sign_up
end

post '/sign_up' do
  User.create!(username: params[:wanted_name], password: params[:access_code])
  redirect '/'
  #stuff for signing up
  end

post '/login' do
  @user = User.authenticate(params[:user_name],params[:access_code])
  if @user.nil?
    redirect '/'
  else
    session[:user_id] = @user.id
    redirect '/login'
  end
  # send logged in data to DB and confirm
end

post '/blink' do
  @blink = Blink.create!(blink_text: params[:new_blink], user_id: session[:user_id])
  # sends a blink message to the DB and back.
  redirect '/login'
end

post '/wink' do
  # winks at a user
end

post '/logout' do
  session.clear
  redirect '/'
end
