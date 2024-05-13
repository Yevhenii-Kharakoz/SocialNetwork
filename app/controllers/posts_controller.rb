class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @posts = Post.all.order("created_at DESC").limit(10) # Загрузка последних 10 постов
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if params[:post][:remove_image] == '1'
      @post.image.purge
    end

    if params[:post][:image].present?
      # Предположим, что у модели Post есть метод attach_image, который корректно обрабатывает загрузку
      if @post.attach_image(params[:post][:image])
        flash[:success] = "Image updated successfully."
      else
        flash[:error] = "Image could not be updated."
      end
    end

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to edit_post_path(@post), alert: 'There was a problem with the file you uploaded. Please try again.'
  end


  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  def attach_image(image)
  end
end
