class RoomsController < ApplicationController

  def index
    # @rooms = Room.all.order(id: "DESC")
    @messages = Message.all
    # 自分以外のユーザー一覧
    @users = User.where.not(id: current_user.id)
    # フォロー中ユーザー
    @followings = current_user.followings
    # フォローされているユーザー
    @followers = current_user.followers
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_index_path
    else
      render new_room_path
    end
  end

  def show
    @messages = Message.all
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to rooms_index_path
  end
  
  private

  def room_params
    # params.require(:room).permit(:name, user_ids: [])
    params.require(:room).permit(:name, room_users_attributes:{user_ids:[]})
  end

end
