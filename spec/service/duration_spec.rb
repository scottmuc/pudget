require_relative '../../lib/services/duration'

describe Duration do
  it "parses 1:02:30 as 62 minutes" do
    duration = Duration.parse("1:02:30")
    expect( duration.minutes ).to eq(62)
  end

  it "parses 59:00 as 59 minutes" do
    duration = Duration.parse("59:00")
    expect( duration.minutes ).to eq(59)
  end

  it "parses 120 as 2 minutes" do
    duration = Duration.parse("120")
    expect( duration.minutes ).to eq(2)
  end

  it "interacts with a parser to obtain a duration" do
    parser = double(:parser)
    expect(parser).to receive(:can_parse).with("120") { true }
    expect(parser).to receive(:parse).with("120")
    duration = Duration.parse("120", [parser])
  end
end

describe SecondsParser do
  it "can parse time formated as a number" do
    parser = SecondsParser.new
    expect(parser.can_parse("120")).to eq true
  end

  it "parses 120 as a 2 minute duration" do
    parser = SecondsParser.new
    expect(parser.parse("120").minutes).to eq 2
  end
end

describe MinutesSecondsParser do
  it "can parse time formated as MM:SS" do
    parser = MinutesSecondsParser.new
    expect(parser.can_parse("45:33")).to eq true
  end

  it "parses 45:33 as a 45 minute duration" do
    parser = MinutesSecondsParser.new
    expect(parser.parse("45:33").minutes).to eq 45
  end

  it "parses 62:33 as a 62 minute duration" do
    parser = MinutesSecondsParser.new
    expect(parser.parse("62:33").minutes).to eq 62
  end
end

describe HoursMinutesSecondsParser do
  it "can parse time formated as HH:MM:SS" do
    parser = HoursMinutesSecondsParser.new
    expect(parser.can_parse("01:45:33")).to eq true
  end

  it "parses 01:45:33 as a 105 minute duration" do
    parser = HoursMinutesSecondsParser.new
    expect(parser.parse("01:45:33").minutes).to eq 105
  end
end

