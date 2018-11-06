json.items do
  json.array!(@items) do |item|
    json.brand item.brand
    json.name item.name
    json.inventory_tag item.inventory_tag
  end
end