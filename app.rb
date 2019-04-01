require_relative 'format'

class App
  def call(env)
    req = Rack::Request.new(env)
    return [404, headers, ['Incorrect path!']] unless correct_path?(req)
    format = Format.new(req.params)
    if format.corrupted?
      [400, headers, ['Unknown time format: ', format.unwanted_params]]
    else
      [200, headers, format.response]
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def correct_path?(req)
    req.path_info == '/time'
  end
end
