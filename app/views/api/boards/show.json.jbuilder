json.(@board, :id, :title, :lists, :members)

json.lists @board.lists do |list|
  json.extract!(list, :id, :title)
end
