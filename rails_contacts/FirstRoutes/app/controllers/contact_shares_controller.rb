class ContactSharesController < ApplicationController
  def create
    share = ContactShare.new(share_params)
    if share.save
      render json: share
    else
      render json: share.errors.full_messages
    end
  end

  def destroy
    share = ContactShare.find(params[:id])
    share.destroy
    render json: share
  end

  private

    def share_params
      params.require(:contact_share).permit(:user_id, :contact_id)
    end
end
