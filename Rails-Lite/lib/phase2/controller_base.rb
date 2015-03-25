module Phase2
  class ControllerBase
    attr_reader :req, :res

    def initialize(req, res)
      @req = req
      @res = res
      @already_built_response = false
    end

    def already_built_response?
      @already_built_response
    end

    def redirect_to(url)
      if already_built_response?
        raise Exception.new("Already rendered!")
      end

      @res.header["location"] = url
      @res.status = 302

      @already_built_response = true
    end

    def render_content(content, content_type)
      if already_built_response?
        raise Exception.new("Already rendered!")
      end

      @res.content_type = content_type
      @res.body = content

      @already_built_response = true
    end
  end
end
