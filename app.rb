require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'
require 'sinatra'
require 'line/bot'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end


get '/' do
  if current_user.nil?
    @submissions = Submission.none
  else
    @submissions = current_user.submissions
  end
  erb :index
end

get '/signup' do
  erb :sign_up
end

get '/signin' do
  erb :sign_in
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/submissions/new' do
  erb :new
end

post '/signup' do
  @user = User.create(name:params[:name], password:params[:password],
  password_confirmation:params[:password_confirmation], line_id:params[:line_id])
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/submissions' do
  current_user.submissions.create(title: params[:title], limit: params[:limit])
  redirect '/'
end

post '/submissions/:id/done' do
  submission = Submission.find(params[:id])
  submission.completed = true
  submission.save
  redirect '/'
end

post '/submissions/:id/delete' do
  submission = Submission.find(params[:id])
  submission.destroy
  redirect '/'
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  puts client
  puts body
  puts signature
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: 'おい'
        }
        client.reply_message(event['replyToken'], message)
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end