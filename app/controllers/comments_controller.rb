class CommentsController < ApplicationController
  def create
    # topicをパラメータの値から探し出し,topicに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.js   { render :index }
      else
        format.html { render :new   }
      end
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    @topic = Topic.find(params[:topic_id])
    redirect_to topic_path(@topic)
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if Comment.find(params[:id]).destroy
        format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
