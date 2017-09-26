module RackApp
  class HTMLWrapper

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
      HTML.new(build_body)
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

    class HTML

      attr_reader :body

      def initialize(body)
        @body = body
      end

      def headers
        Headers
      end

      Headers = { "Content-Type" => "text/html" }
    end
  end
end
