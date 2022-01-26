class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new 
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: '保存完了'
    else
      flash.now[:error] = '保存に失敗'
      render :new
    end
  end

    def edit
      @post = current_user.posts.find(params[:id])
    end

    def update
      @post = current_user.posts.find(params[:id])
      if @post.update(post_params)
        redirect_to post_path(@post), notice: '更新完了'
      else
        flash.now[:error] = '更新に失敗'
        render :new
      end
    end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to root_path, notice: '削除成功'
  end

  private 
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end