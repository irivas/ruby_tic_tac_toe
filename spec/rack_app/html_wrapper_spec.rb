require "rack"
require "rack_app/html_wrapper"

describe RackApp::HTMLWrapper do
  context "blank page with no content" do 
    let(:html_doc) { RackApp::HTMLWrapper.new.build }

    it "builds a blank html page" do
      expect(html_doc.body.join("")).to match(/<html><head><\/head><body><\/body><\/html>/)
    end

    it "builds standard html headers" do
      expect(html_doc.headers["Content-Type"]).to eq("text/html")
    end
  end

  context "appending simple body content" do
    let(:html_doc) { 
      RackApp::HTMLWrapper
        .new
        .append_to_body("Some simple content. ")
        .append_to_body("Some more content.")
        .build 
    }

    it "adds content to body in order" do
      expect(html_doc.body.join("")).to match(/<body>Some simple content. Some more content.<\/body>/)
    end
  end

  context "apppending simple header content" do
    let(:html_doc) { 
      RackApp::HTMLWrapper
        .new
        .append_to_head("<script src=\"a/simple/script/include\"></script>")
        .build 
    }

    it "adds content to body in order" do
      expect(html_doc.body.join("")).to match(
        /<head><script src="a\/simple\/script\/include"><\/script><\/head>/)
    end
  end
end
