class Geek
  def call(env)
    # [200,{},["Hello, Geek 22"]]
    @request = Rack::Request.new(env)
    case @request.path 
      when '/' 
        Rack::Response.new(render("index.html.erb"))
      when '/post_form'
        Rack::Response.new do |response|
          response.set_cookie('geek_name', @request.params["name"] )
          response.redirect('/')
        end
      else
        posted_name = @request.params["name"] || ''
        Rack::Response.new("Not found #{posted_name}",404)
      end
  end
  
  def render(filename)
    path = File.expand_path("../../views/#{filename}",__FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def geek_name
    @request.cookies['geek_name'] || 'GEEEEK++NAME'
  end
end
