require_relative '../../app/domain/duration'

describe Duration do
  it "interacts with a parser to obtain a duration" do
    parser = double(:parser)
    expect(parser).to receive(:can_parse).with("120") { true }
    expect(parser).to receive(:parse).with("120") { Duration.new 120 }
    duration = Duration.parse("120", [parser])
    expect( duration.minutes ).to eq 120
  end

  it "parses 59:00 as 59 minutes" do
    duration = Duration.parse("59:00")
    expect( duration.minutes ).to eq 59
  end

  it "parses 1:02:30 as 62 minutes" do
    duration = Duration.parse("1:02:30")
    expect( duration.minutes ).to eq 62
  end

  it "parses 600 as 10 minutes" do
    duration = Duration.parse("600")
    expect( duration.minutes ).to eq 10
  end

  it "parses nil as 0 minutes" do
    no_parsers = []
    duration = Duration.parse(nil, no_parsers)
    expect( duration.minutes ).to eq 0
  end

  describe Duration::DefaultParser do
    it "can parse any non-sensical string" do
      expect(subject.can_parse("")).to eq true
      expect(subject.can_parse("UNKNOWN")).to eq true
      expect(subject.can_parse("12-40-30")).to eq true
    end

    it "parses all non-sensical strings as a 0 minute duration" do
      expect(subject.parse("").minutes).to eq 0
      expect(subject.parse("UNKNOWN").minutes).to eq 0
      expect(subject.parse("12-40-30").minutes).to eq 0
    end
  end

  describe Duration::HoursMinutesSecondsParser do
    it "can parse time formated as HH:MM:SS" do
      expect(subject.can_parse("01:45:33")).to eq true
      expect(subject.can_parse("00:45:33")).to eq true
    end

    it "parses 01:45:33 as a 105 minute duration" do
      expect(subject.parse("01:45:33").minutes).to eq 105
      expect(subject.parse("00:45:33").minutes).to eq 45
    end
  end

  describe Duration::MinutesSecondsParser do
    it "can parse time formated as MM:SS" do
      expect(subject.can_parse("45:33")).to eq true
      expect(subject.can_parse("5:33")).to eq true
    end

    it "parses 45:33 as a 45 minute duration" do
      expect(subject.parse("45:33").minutes).to eq 45
      expect(subject.parse("5:33").minutes).to eq 5
    end

    it "parses 62:33 as a 62 minute duration" do
      expect(subject.parse("62:33").minutes).to eq 62
    end
  end

  describe Duration::SecondsParser do
    it "can parse time formated as a number" do
      expect(subject.can_parse("120")).to eq true
    end

    it "parses 120 as a 2 minute duration" do
      expect(subject.parse("120").minutes).to eq 2
    end
  end
end

