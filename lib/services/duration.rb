require_relative 'string_parser'

class Duration
  attr_reader :minutes

  class NullParser < StringParser
    def initialize
      super( Proc.new { |_| true },
             Proc.new { |_| Duration.new(0) })
    end
  end

  class HoursMinutesSecondsParser < StringParser
    def initialize
      super( Proc.new { |string| string.split(':').count == 3 },
             Proc.new { |string|
               midnight = Time.parse('00:00:00')
               duration = Time.parse(string) - midnight
               Duration.new(duration.to_i / 60)
             }
           )
    end
  end

  class MinutesSecondsParser < StringParser
    def initialize
      super( Proc.new { |string| string.split(':').count == 2 },
             Proc.new { |string|
               minutes = string.split(':')[0].to_i
               Duration.new(minutes)
             }
           )
    end
  end

  class SecondsParser < StringParser
    def initialize
      super( Proc.new { |string| string.split(':').count == 1 },
             Proc.new { |string| Duration.new(string.to_i / 60) }
           )
    end

  end

  BUILT_IN_PARSERS = [
    SecondsParser.new,
    MinutesSecondsParser.new,
    HoursMinutesSecondsParser.new,
    NullParser.new,
  ]

  def initialize(minutes)
    @minutes = minutes
  end

  def self.parse(string, parsers=BUILT_IN_PARSERS)
    return Duration.new(0) if string.nil?
    parser = parsers.find { |parser| parser.can_parse string }
    parser.parse string
  end
end

