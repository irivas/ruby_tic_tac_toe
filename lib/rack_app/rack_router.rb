module RackApp
  class RackRouter
    def initialize
      @routes = []
    end

    def call(env)
      request = Rack::Request.new(env)
      dispatch_to(find_route(request), request)
    end

    def add(route)
      @routes << route
      self
    end

    private

    def find_route(request)
      @routes.find { |route| matching_route(request, route) }
    end

    def matching_route(request, route)
      route.path == request.path && 
      route.request_methods.include?(request.request_method)
    end

    def dispatch_to(route, request)
      if route
        route.handler(request)
      else
        route_not_found
      end
    end

    def route_not_found
      [ 404,
        { "Content-Type" => "text/plain" },
        ["404 Error: Page not found"]
      ]
    end
  end
end
