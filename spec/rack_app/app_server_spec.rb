require "rack"
require "rack_app/app_server"

describe AppServer do
  context "get to /tic-tac-toe" do
    let(:app) { AppServer.new }
    let(:response) { Rack::MockRequest.new(app).get("/tic-tac-toe") }

    it "has status of 200" do
      expect(response.status).to eq(200)
    end

    it "has body of 'Boom'" do
      expect(response.body).to eq("Boom")
    end
  end
end
