$LOAD_PATH.unshift(File.dirname(__FILE__), "lib")

require "rack_app/rack_router"
require "rack_app/static_route_handler"
require "rack_app/game_handler"

static_route_handler = RackApp::StaticRouteHandler.new(File.expand_path("./static"))

game_handler = RackApp::GameHandler.new(path: "/tic-tac-toe", 
                                        request_methods: ["GET", "POST"])

router = RackApp::RackRouter.new
router.add(static_route_handler)
router.add(game_handler)

run(router)
