class Duration
  attr_reader :minutes

  MIDNIGHT = Time.parse('00:00:00')

  def initialize(minutes)
    @minutes = minutes
  end

  def self.parse(string)
    if string.split(':').count == 1
      return Duration.new(string.to_i / 60)
    end
    if string.split(':').count == 2
      string = '00:' + string
    end
    duration = Time.parse(string) - MIDNIGHT
    Duration.new(duration.to_i / 60)
  end
end

