module Api
  class ItemsController < ApiController
    def create
    end

    def update
      @item = Item.find(params[:id])
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors.full_messages,
               status: :unprocessable_entity
      end
    end

    def destroy
    end
  end
end
