require 'line/bot'
require './models'
require 'dotenv'

Dotenv.load

 def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

#  events = client.parse_events_from(body)
#   events.each { |event|
#     case event
#     when Line::Bot::Event::Message
#       case event.type
#       when Line::Bot::Event::MessageType::Text
        message = []
        submissions = Submission.all
        submissions.each do |submission|
           if submission.limit < Date.today && !(submission.completed)
        message.push({
          type: 'text',
           text: "#{submission.title}の#{submission.limit}を過ぎてます"
        })
           end
        end
         response = client.push_message('U24a0e3de078dc4dec17fb011a1fb14a9', message)
      # when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
      #   response = client.get_message_content(event.message['id'])
      #   tf = Tempfile.open("content")
      #   tf.write(response.body)
  #     end
  #   end
  # }