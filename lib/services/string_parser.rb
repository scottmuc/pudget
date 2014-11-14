class StringParser
  def initialize(can_parse_proc, parse_proc)
    @can_parse_proc = can_parse_proc
    @parse_proc = parse_proc
  end

  def can_parse(string)
    @can_parse_proc.call string
  end

  def parse(string)
    @parse_proc.call string
  end
end

