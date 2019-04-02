class Format
  VALUES = {'year' => '%Y-',
            'month' => '%m-',
            'day' => '%d',
            'hour' => '%H:',
            'minute' => '%M:',
            'second' => '%S' }.freeze

  def initialize(parts)
    @parts = parts
    @requested = @parts & VALUES.keys
    @answer = ''
  end

  def corrupted?
    true unless @parts.all? { |e| VALUES.key?(e) }
  end

  def unwanted_params
    @parts - VALUES.keys
  end

  def response
    @requested.each { |format| @answer += VALUES[format] }
    Time.now.strftime(@answer)
  end
end
