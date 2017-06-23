class BandsController < ApplicationController
  before_action :logged_in_user

  def new
    @band = Band.new
  end

  def index
  end

  def create
    band = Band.new(band_params)

    if band.save
      redirect_to bands_url
    else
      flash.now[:errors] = ["You have to name the band."]
      render :new
    end
  end

  def edit
    @band = Band.find_by_name(params[:id])
  end

  def show
    @band = Band.find(params[:id])
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
