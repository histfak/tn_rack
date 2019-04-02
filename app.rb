require_relative 'format'

class App
  def call(env)
    req = Rack::Request.new(env)
    return make_response(404, 'Incorrect path!') unless correct_path?(req)
    return make_response(404, 'Incorrect format!') unless req.params['format']
    format = Format.new(req.params['format'].split(','))
    if format.corrupted?
      make_response(400, "Unknown time format: #{format.unwanted_params.join(', ')}")
    else
      make_response(200, format.response)
    end
  end

  private

  def headers
    {'Content-Type' => 'text/plain'}
  end

  def make_response(status, body)
    [status, headers, [body]]
  end

  def correct_path?(req)
    req.path_info == '/time' && req.scheme == 'http'
  end
end
