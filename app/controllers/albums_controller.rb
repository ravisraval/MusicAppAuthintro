class AlbumsController < ApplicationController
  before_action :logged_in_user

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band)
    else
      flash.now[:errors] = ["You have to name the band and designate live/studio recorded."]
      render :new
    end

  end

  def show
    @album = Album.find(params[:id])
  end

  private
  def album_params
    params.require(:album).permit(:name, :live, :band_id)
  end
end
