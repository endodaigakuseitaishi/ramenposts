class CommentsController < ApplicationController
  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.build
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(post), notice: '追加'
    else
      flash.now[:error] = '追加できず'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end