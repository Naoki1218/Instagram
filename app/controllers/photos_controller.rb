class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def show
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
    @comment = Comment.new
    @comment.photo_id = params[:photo_id]
    @comments = @photo.comments
  end

  def new
    if params[:back]
      @photo = Photo.new(photo_params)
    else
      @photo = Photo.new
    end
  end

  def edit
  end

  def confirm
    @photo = current_user.photos.build(photo_params)
    render :new if @photo.invalid?
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if params[:back]
      render :new
    elsif @photo.save
      PhotoMailer.photo_mail(@photo).deliver
      redirect_to photos_path, notice: 'アップされました！'
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: '編集しました！'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: '削除完了しました！'
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:photo, :content, :photo_cache)
    end
end
