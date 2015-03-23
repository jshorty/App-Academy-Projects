class NotesController < ApplicationController

  def create
    @note = Note.new(text: params[:note][:text],
                     user_id: current_user.id,
                     track_id: params[:track_id])
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:error] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @track_id = @note.track_id
    if current_user.id == @note.user_id
      @note.destroy
      redirect_to track_url(@track_id)
    else
      render status: 403
    end
  end
end
