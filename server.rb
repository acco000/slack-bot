require 'sinatra'
require 'json'

require './slack'

slack = SlackAPIWrapper.new('xoxb-2022530838257-2100275514548-LXmNMUApIk8c0U0mQVHIvBgg')

# http://localhost:4567でブラウザからアクセスできる
get '/' do
  'hello'
end

# slackに発生したイベントを受け取る場所
post '/' do
  body = request.body.read
  json_body = JSON.parse(body, symbolize_names: true)

  # 認証に必要
  return json_body[:challenge] if json_body[:type] == 'url_verification'

  event = json_body[:event]

  # メンションを受け取った時の処理
  if event[:type] == 'app_mention'

    # 受け取ったテキストの取得
    text = event[:text]
    channel = event[:channel]
    user = event[:user]
    puts text
    # slackにメッセージを送信
    if /hello/ =~ text
        slack.chat_post_message("Hello, <@#{user}>, from #{text}" ,channel)
    elsif /How are you/ =~ text
        slack.chat_post_message("Fine TY, <@#{user}>, from #{text}" ,channel)
    end
  end
  return 200
end