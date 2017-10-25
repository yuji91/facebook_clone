class TopicsController < ApplicationController
 before_action :authenticate_user!
 before_action :set_topic, only: %i[edit show update destroy]
  def index
    @topics = Topic.all.includes(:user)
  end
  
  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "写真を投稿しました！"
      #TODO:mailer実装後に有効化
      #NoticeMailer.sendmail_topic(@topic).deliver
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def edit; end
    
  def show
    @comment  = @topic.comments.build
    @comments = @topic.comments
  end
  
  def update
    @topic.update(topics_params)
    redirect_to topics_path
  end
  
  def destroy
    @topic.destroy
    redirect_to topics_path
  end
  
  private
    def topics_params
      params.require(:topic).permit(:content,:picture)
    end
    
    def set_topic
      @topic = Topic.find(params[:id])
    end
end

