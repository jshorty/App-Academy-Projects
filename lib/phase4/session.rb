require 'json'
require 'webrick'

module Phase4
  class Session
    def initialize(req)
      cookies = req.cookies.select {|cookie| cookie.name == '_rails_lite_app'}
      cookie = cookies.first

      if req.cookies.include?(cookie)
        @content = JSON.parse(cookie.value)
      else
        @content = {}
      end
    end

    def [](key)
      @content[key]
    end

    def []=(key, val)
      @content[key] = val
    end

    def store_session(res)
      cookie = WEBrick::Cookie.new('_rails_lite_app', @content.to_json)
      res.cookies << cookie
    end
  end
end
