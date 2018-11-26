object false
node(:success) { "true" }
child @members, :root => "results", :object_root => false do
  attributes :full_name => :title
  attributes :id_number => :description
  node(:actionUrl) { |m| member_path(m.id) }
  # attributes :full_name => :url
  # node(:url) { "/members/" + :id }
end
# node(:state) { |city| city.state.name }
# node(:query) { params[:query] }