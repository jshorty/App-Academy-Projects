class BandsController < ApplicationController

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band.id)
    else
      flash.now[:errors] = ["error entering the band to database"]
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band.id)
    else
      flash.now[:errors] = ["error editing the band's name"]
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  def index
    @bands = Band.all
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
