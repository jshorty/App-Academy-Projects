json.(@board, :id, :title, :members)

json.lists @board.lists do |list|
  json.extract!(list, :id, :title, :board_id, :ord)

  json.cards list.cards do |card|
    json.extract!(card, :id, :title, :list_id, :description, :ord)

    json.items card.items do |item|
      json.extract!(item, :title, :card_id, :done)
    end
  end
end
