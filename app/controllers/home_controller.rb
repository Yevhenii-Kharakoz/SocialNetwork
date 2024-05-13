class HomeController < ApplicationController
  def index
    @posts = Post.all.order("created_at DESC").limit(10) # Загрузка последних 10 постов
  end
end
