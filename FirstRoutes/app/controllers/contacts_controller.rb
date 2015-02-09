class ContactsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    contacts = Contact.where(user_id: params[:user_id])
    shared_contacts = user.shared_contacts
    render json: contacts + shared_contacts
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages
    end

  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy!
    render json: contact
  end

  def favorite
    contact = Contact.find(params[:contact_id])
    if contact.user_id == params[:user_id].to_i
      contact.favorite ? new_fav = false : new_fav = true
      contact.update({favorite: new_fav})

      render json: contact
    elsif contact.contact_shares.exists?(user_id: params[:user_id])
      fav = contact.contact_shares.where(user_id: params[:user_id]).first
      fav.favorite ? new_fav = false : new_fav = true
      fav.update({favorite: new_fav})
      render json: fav
    else
      raise "You can't favorite a contact that wasn't shared with you"
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:user_id, :name, :email)
  end

end
