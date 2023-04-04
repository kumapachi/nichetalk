class RoomChannel < ApplicationCable::Channel
  def subscribed
    # 接続
    stream_from "room_channel"
  end

  def unsubscribed
    # 切断
  end

  # coffeeから送られて来たmessage(event.target.value)を受け取る
  # inputタグの文字がメッセージカラムに保存される
  def speak(data)
    # Message.create(message: data['message'], user_id: data['user'].to_i)
    # room_channelに紐づくjsにメッセージの内容を配信する
    ActionCable.server.broadcast 'room_channel', message: data['message']
  end
en
