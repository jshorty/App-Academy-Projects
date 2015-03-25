class PostsController < ApplicationController
  before_action :owns_post, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create

    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post.id)
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
      redirect_to post_url(@post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments
    render :show
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end

  def owns_post
    unless current_user.id == Post.find(params[:id]).author_id
      flash[:errors] = ["You are not the author of this post"]
      redirect_to post_url(params[:id])
    end
  end
end
