class PostsController < ApplicationController
  before_action :owns_post, only: [:edit, :update]

  def new
    @post = Post.new
    @sub_id = params[:sub_id]
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_post_url(@post.sub_id, @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_post_url(@post.sub_id, @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def post_params
    params.require(:post).permit(:title, :content, :url)
  end

  def owns_post
    unless current_user.id == Post.find(params[:id]).author_id
      flash[:errors] = ["You are not the author of this post"]
      redirect_to sub_post_url(Post.find(params[:id]).sub_id, params[:id])
    end
  end
end
