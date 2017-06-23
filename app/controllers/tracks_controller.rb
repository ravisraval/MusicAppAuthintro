class TracksController < ApplicationController
  before_action :logged_in_user

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = ["Make sure you fill out all track fields."]
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  private
  def track_params
    params.require(:track).permit(:name, :bonus, :lyrics, :album_id)
  end

end
