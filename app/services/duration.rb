class Duration
  class DefaultParser
    def can_parse(string)
      true
    end

    def parse(string)
      Duration.new 0
    end
  end

  class HoursMinutesSecondsParser
    def can_parse(string)
      string.split(':').count == 3
    end

    def parse(string)
      midnight = Time.parse('00:00:00')
      duration = Time.parse(string) - midnight
      Duration.new(duration.to_i / 60)
    end
  end

  class MinutesSecondsParser
    def can_parse(string)
      string.split(':').count == 2
    end

    def parse(string)
      minutes = string.split(':')[0].to_i
      Duration.new minutes
    end
  end

  class SecondsParser
    def can_parse(string)
      string.split(':').count == 1
    end

    def parse(string)
      Duration.new(string.to_i / 60)
    end
  end

  BUILT_IN_PARSERS = [
    SecondsParser.new,
    MinutesSecondsParser.new,
    HoursMinutesSecondsParser.new,
    DefaultParser.new,
  ]

  attr_reader :minutes

  def initialize(minutes)
    @minutes = minutes
  end

  def self.parse(string, parsers=BUILT_IN_PARSERS)
    return Duration.new(0) if string.nil?
    parser = parsers.find { |parser| parser.can_parse string }
    parser.parse string
  end
end

