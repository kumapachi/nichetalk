class RoomsController < ApplicationController

  def index
  end

  def new
    @room = Room.new
    @room.room_users.build
  end

  def create
    # @topic = Topic.find(params[:topic_id])
    # @user = User.find(params[:user_id])
    @room = Room.new(room_params)
    # @room = Room.find(params[:id])
    # @room = current_user.rooms.create(room_params)
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
    params.require(:room).permit(:name, room_users_attributes:{user_ids:[]})
  end

end
