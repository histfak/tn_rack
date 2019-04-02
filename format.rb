class Format
  FORMATS = {'year' => '%Y-',
             'month' => '%m-',
             'day' => '%d',
             'hour' => '%H:',
             'minute' => '%M:',
             'second' => '%S' }.freeze

  def initialize(parts)
    @valid, @invalid = parts.partition { |part| FORMATS.key?(part) }
  end

  def corrupted?
    true unless @invalid.empty?
  end

  def unwanted_params
    @invalid
  end

  def response
    answer = ''
    @valid.each { |format| answer += FORMATS[format] }
    Time.now.strftime(answer)
  end
end
