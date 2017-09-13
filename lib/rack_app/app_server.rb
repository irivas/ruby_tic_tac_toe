class AppServer
  def call(env)
    [ 200,
      { "Content-Type": "text/html" },
      ["Boom"]]
  end
end
