require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    def render(template_name)
      controller = self.class.to_s.underscore

      erb = ERB.new(
        File.read("views/#{controller}/#{template_name}.html.erb")
        )

      render_content(erb.result(binding), "text/html")
    end
  end
end
