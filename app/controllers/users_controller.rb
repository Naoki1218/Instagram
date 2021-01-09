class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :favorites]
  before_action :only_your_page, only: [:edit, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    # @user = User.find(params[:id])
    # if @user == current_user
    # else
    #   redirect_to photos_path, notice: "他者のページアクセスできません"
    # end
  end

  def show
    @user = User.find(params[:id])
    # if @user == current_user
    # else
    #   redirect_to photos_path, notice: "他者のページアクセスできません"
    # end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "画像を編集しました！"
    else
      render :edit
    end
  end

  def favorites
    @favorite_photos = @user.favorite_photos
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation, :image, :image_cache, :profile)
  end

  def only_your_page
    if @user == current_user
    else
      redirect_to photos_path, notice: "他者のページアクセスできません"
    end
  end
end
