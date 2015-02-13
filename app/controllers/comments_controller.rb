class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
