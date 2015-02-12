class TracksController < ApplicationController

  def new
    @album = Album.find(params[:album_id])
    @albums = Album.all
    @track = Track.new
    render :new
  end

  def edit
    @albums = Album.all
    @track = Track.find(params[:id])
    render :edit
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy
    redirect_to album_url(@album.id)
  end

  private

  def track_params
    params.require(:track).permit(:name, :bonus, :album_id, :lyrics)
  end
end
