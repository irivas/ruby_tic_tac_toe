require "rack"

module RackApp
  class HTMLWrapper
    Headers = { "Content-Type" => "text/html" }
    Status = 200

    def initialize
      @head_contents = []
      @body_contents = []
    end

    def append_to_head(head_content)
      @head_contents << head_content
      self
    end

    def append_to_body(body_content)
      @body_contents << body_content
      self
    end

    def build
      Rack::Response.new(
        build_body,
        Status,
        Headers)
    end

    private 
    
    def build_body
      [StartDoc,
      StartHead,
      @head_contents,
      EndHead,
      StartBody,
      @body_contents,
      EndBody,
      EndDoc].flatten
    end

    StartDoc = ["<html>"]
    StartHead = ["<head>"]
    EndHead = ["</head>"]
    StartBody = ["<body>"]
    EndBody = ["</body>"]
    EndDoc = ["</html>"]
  end
end
