json.items do
  json.array!(@items) do |item|
    json.name item.name
    json.inventory_tag item.inventory_tag
  end
end