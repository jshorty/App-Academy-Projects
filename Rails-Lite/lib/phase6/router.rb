require 'active_support/inflector'

module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern = pattern
      @http_method = http_method
      @controller_class = controller_class
      @action_name = action_name
    end

    def matches?(req)
       req.request_method.downcase.to_sym == http_method && !!pattern.match(req.path)
    end

    def run(req, res)
      route_params = {}
      url_str = pattern.match(req.path).to_s
      id_pairs = parse_id_pairs(url_str)

      #for nested resource, use "id"
      unless id_pairs.empty?
        parse_nested_resource(id_pairs.pop, route_params)
      end

      #for any parent resources, use "resource_id"
      unless id_pairs.empty?
        parse_parent_resources(id_pairs, route_params)
      end

      controller_class.new(req, res, route_params).invoke_action(action_name)
    end

    def parse_id_pairs(url_str)
      url_str.scan(/(\/\w+($|\/\d+))/).map(&:first).flatten
    end

    def parse_parent_resources(id_pairs, route_params)
      id_pairs.each do |str|
        match = (/\/(?<obj>\w+)\/(?<id>\d+)/).match(str)
        id_name = match[:obj].downcase.singularize + "_id" #!!!
        route_params[id_name] = match[:id]
      end
    end

    def parse_nested_resource(nested_resource, route_params)
      match = (/\/(?<id>\d+)/).match(nested_resource)
      unless match.nil?
        route_params[match.names.first] = match.captures.first
      end
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end

    def draw(&proc)
      self.instance_eval(&proc)
    end

    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end

    def match(req)
      @routes.find {|route| route.matches?(req)}
    end

    def run(req, res)
      route = match(req)
      if route.nil?
        res.status = 404
      else
        route.run(req, res)
      end
    end
  end
end
