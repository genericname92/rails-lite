require 'json'
require 'webrick'

module Phase7
  class Flash
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      req.cookies.each do |cookie|
        if cookie.name == '_flash_rails_lite_app'
          @cookie = cookie
          @flash_now = JSON.parse(@cookie.value.to_s)
        end
      end
      if @cookie.nil?
        @cookie = WEBrick::Cookie.new('_flash_rails_lite_app', {})
        @flash_now = JSON.parse(@cookie.value.to_s)
      end
      @flash = {}
    end

    def [](key)
      @value[key]
    end

    def []=(key, val)
      @value[key] = val
    end

    def now
      @flash_now
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie = WEBrick::Cookie.new('_flash_rails_lite_app', @value.to_json)
      res.cookies << cookie
    end
  end
end
