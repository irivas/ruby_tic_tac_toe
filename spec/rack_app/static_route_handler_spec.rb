require "ostruct"
require "rack_app/static_route_handler"

describe RackApp::StaticRouteHandler do
  let(:base_path) { "path/to/static/dir" }
  let(:matching_path) { "matching_file" }
  let(:matching_js_path) { "matching_file.js" }
  let(:matching_css_path) { "matching_file.css" }
  let(:matching_html_path) { "matching_file.html" }
  let(:matching_content) { "matching content" }
  let(:missing_path) { "missing_file" }
  let(:route_handler) { RackApp::StaticRouteHandler.new(base_path) }

  before(:each) do
    mock_success_path(matching_path)
    mock_success_path(matching_js_path)
    mock_success_path(matching_css_path)
    mock_success_path(matching_html_path)
    allow(File).to receive(:exists?).with(File.join(base_path, missing_path)).and_return(false)
  end

  it "only registers for GET requests" do
    expect(route_handler.request_methods).to eq(["GET"])
  end

  context "matching static file path" do
    it "path method's response will match route" do
      expect(route_handler.path == matching_path).to be true
    end

    it "handler return rack response with body of file contents" do
      request = build_request(matching_path)
      response = route_handler.handler(request)
      
      expect(response.status).to eq(200)
      expect(response.headers["Content-Type"]).to eq("text/plain")
    end
  end

  context "missing static file path" do
    it "path method's response won't match route" do
      expect(route_handler.path == missing_path).to be false 
    end
  end

  context "matching js file path" do
    it "handler returns rack response with content type header of application/js" do
      request = build_request(matching_js_path)
      response = route_handler.handler(request)

      expect(response.status).to eq(200)
      expect(response.headers["Content-Type"]).to eq("application/js")
    end
  end

  context "matching css file path" do
    it "handler returns rack response with content type header of text/css" do
      request = build_request(matching_css_path)
      response = route_handler.handler(request)

      expect(response.status).to eq(200)
      expect(response.headers["Content-Type"]).to eq("text/css")
    end
  end

  context "matching html file path" do
    it "handler returns rack response with content type header of text/html" do
      request = build_request(matching_html_path)
      response = route_handler.handler(request)

      expect(response.status).to eq(200)
      expect(response.headers["Content-Type"]).to eq("text/html")
    end
  end

  def build_request(path)
    OpenStruct.new({ path: path })
  end

  def mock_success_path(path)
    allow(File).to receive(:exists?).with(File.join(base_path, path)).and_return(true)
    allow(File).to receive(:read).with(File.join(base_path, path)).and_return(matching_content)
  end
end

