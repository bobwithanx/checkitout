json.members do
  json.array!(@members) do |member|
    json.name member.full_name
    json.id_number member.id_number
    json.url member_path(member)
  end
end