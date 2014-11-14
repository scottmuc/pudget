
class SecondsParser
  def can_parse(string)
    string.split(':').count == 1
  end

  def parse(string)
    Duration.new(string.to_i / 60)
  end
end

class MinutesSecondsParser
  def can_parse(string)
    string.split(':').count == 2
  end

  def parse(string)
    minutes = string.split(':')[0].to_i
    Duration.new(minutes)
  end
end

class HoursMinutesSecondsParser
  MIDNIGHT = Time.parse('00:00:00')

  def can_parse(string)
    string.split(':').count == 3
  end

  def parse(string)
    duration = Time.parse(string) - MIDNIGHT
    Duration.new(duration.to_i / 60)
  end
end

class Duration
  attr_reader :minutes

  BUILT_IN_PARSERS = [
    SecondsParser.new,
    MinutesSecondsParser.new,
    HoursMinutesSecondsParser.new,
  ]

  def initialize(minutes)
    @minutes = minutes
  end

  def self.parse(string, parsers=BUILT_IN_PARSERS)
    parser = parsers.find { |parser| parser.can_parse string }
    parser.parse string
  end
end

