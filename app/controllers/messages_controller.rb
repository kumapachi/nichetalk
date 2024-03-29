class MessagesController < ApplicationController
  def index
    @message = Message.new
    @topic = Topic.find(params[:topic_id])
    @room = Room.find(params[:room_id])
    @rooms = Room.all.order(id: "DESC")
    @messages = @room.messages.includes(:user)
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @room = Room.find(params[:room_id])
    @rooms = Room.all.order(id: "DESC")
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to topic_room_messages_path(@topic, @room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:comment, :image).merge(user_id: current_user.id, topic_id: params[:topic_id], room_id: params[:room_id])
  end

end
