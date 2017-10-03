require "rack"
require "ostruct"
require "rack_app/rack_router"

describe RackApp::RackRouter, router: true do
  let(:rack_router) { 
    rack_router = RackApp::RackRouter.new 
    rack_router.add(TestRoute.new)
    rack_router
  }

  let(:app) { Rack::MockRequest.new(rack_router) }

  context "undefined route" do
    it "responds with 404" do
      response = app.get("/test-route")
      expect(response.status).to eq(404)
    end
  end

  context "matched route" do
    it "responds with 200 if matched request method" do
      response = app.get("/matched-route")
      expect(response.status).to eq(200)
    end

    it "responds with 404 if no matched request method" do
      response = app.post("/matched-route")
      expect(response.status).to eq(404)
    end
  end

  class TestRoute
    def path() "/matched-route" end
    def request_methods() ["GET"] end
    def handler(request) 
      [200, 
      { "Content-Type" => "text/plain" },
      ["Success"]]
    end
  end
end
