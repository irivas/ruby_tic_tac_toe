$LOAD_PATH.unshift(File.dirname(__FILE__), "lib")

require "rack_app/rack_router"
require "rack_app/static_route_handler"

router = RackApp::RackRouter.new
static_route_handler = RackApp::StaticRouteHandler.new(File.expand_path("./static"))
router.add(static_route_handler)

run(router)
