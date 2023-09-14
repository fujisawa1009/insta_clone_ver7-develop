class PostsController < ApplicationController
  # 未ログイン時は新規投稿や編集ができないような制御
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @q = if logged_in?
           current_user.feed.ransack(params[:q])
         else
           Post.ransack(params[:q])
         end
    @pagy, @posts = pagy(@q.result(distinct: true)
                           .with_attached_images.includes(user: { avatar_attachment: :blob }).order(created_at: :desc))
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(user: { avatar_attachment: { blob: :variant_records } })
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), success: '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: '投稿を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました', status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
