class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update]

  def index
    @topics = Topic.all.order('created_at DESC')
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy if current_user == @topic.user_id
    redirect_to root_path
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content, {images: []}).merge(user_id: current_user.id)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end