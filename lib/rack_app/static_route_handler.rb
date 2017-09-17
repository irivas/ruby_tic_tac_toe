require "rack"

module RackApp
  class StaticRouteHandler

    attr_reader :path, :request_methods

    def initialize(base_path)
      @base_path = base_path
      @path = PathMatcher.new(self)
      @request_methods = Request_Methods
    end

    def handler(request)
      response = Rack::Response.new([body(request.path)])
      response.set_header("Content-Type", content_type_header(request.path))
      response
    end

    def exists?(path)
      File.exists?(full_path(path))
    end

    private

    def content_type_header(path)
      case path
      when /\.js$/ then "application/js"
      when /\.css$/ then "text/css"
      else "text/plain"
      end
    end

    def body(path)
      File.read(full_path(path))
    end

    def full_path(path)
      File.join(@base_path, path)
    end

    class PathMatcher
      def initialize(route_handler)
        @route_handler = route_handler
      end

      def ==(path)
        @route_handler.exists?(path)
      end
    end

    Request_Methods = ["GET"]
  end
end
