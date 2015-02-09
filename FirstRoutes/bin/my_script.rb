require 'addressable/uri'
require 'rest-client'


def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/4.json',

  ).to_s

  puts RestClient.delete(url)
end

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/2.json',

  ).to_s

  puts RestClient.delete(url, {contact: {name: "Benjamin", email: "ben@ben.ben", user_id: 3}})
end
