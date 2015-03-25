require 'json'
require 'webrick'

module Phase4
  class Session
    def initialize(req)
      @flash = Flash.new
      cookie = req.cookies.select {|c| c.name == '_rails_lite_app'}.first

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
      flash_cookie = WEBrick::Cookie.new('_rails_lite_app_flash', @flash,)
    end
  end
end
