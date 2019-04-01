require 'set'

class Format
  VALUES = {'year' => '%Y-',
            'month' => '%m-',
            'day' => '%d',
            'hour' => '%H:',
            'minute' => '%M:',
            'second' => '%S' }.freeze

  def initialize(hash)
    @parts = hash['format'].split(',')
    @answer = ''
  end

  def corrupted?
    true unless @parts.to_set.subset?(VALUES.keys.to_set)
  end

  def unwanted_params
    (@parts - VALUES.keys).to_a.join(', ')
  end

  def response
    requested.each { |format| @answer += Time.now.strftime(VALUES[format]) }
    [@answer.to_s]
  end

  private

  def requested
    @parts.to_set.intersection(VALUES.keys.to_set)
  end
end
