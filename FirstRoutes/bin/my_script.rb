require 'addressable/uri'
require 'rest-client'


def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json',

  ).to_s

  puts RestClient.put(url,  { user: { name: "Gizmo2", email: "gizmo@gizmo.gizmo"}})
end
