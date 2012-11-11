require "erb"

class Application
  def self.call(env)
    new(env).route.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def route
    if @request.path.match("^\/$")
      render :index, :status => 200
    else
      response("Not Found", 404)
    end
  end

  def response(*args)
    Rack::Response.new(*args)
  end

  def render(view_name, options = {})
    template = ERB.new(File.read(path_for(view_name))).result(binding)
    response(template, options[:status] || 200)
  end

  def path_for(template)
    File.expand_path("views/#{template}.html.erb")
  end
end
