class RoomsController < ApplicationController

  def index
  end

  def new
    @room = Room.new
  end

  def create
    # @topic = Topic.find(params[:topic_id])
    @room = Room.new(room_params)
    # @room = Room.find(params[:id])
    if @room.save
      redirect_to rooms_index_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end
  
  private

  def room_params
    params.require(:room).permit(:name, user_ids: []).merge(topic_id: params[:topic_id])
  end

end
