require_relative '../../lib/services/duration'
require_relative '../../lib/services/string_parser'

describe Duration do
  describe Duration::NullParser do
    it "can parse time formated as HH:MM:SS" do
      expect(subject.can_parse("")).to eq true
    end

    it "parses 01:45:33 as a 105 minute duration" do
      expect(subject.parse("").minutes).to eq 0
    end

    it "parses nil as 0 minutes" do
      duration = Duration.parse(nil)
      expect( duration.minutes ).to eq 0
    end

    it "parses UNKNOWN as 0 minutes" do
      duration = Duration.parse("UNKNOWN")
      expect( duration.minutes ).to eq 0
    end
  end

  describe Duration::HoursMinutesSecondsParser do
    it "can parse time formated as HH:MM:SS" do
      expect(subject.can_parse("01:45:33")).to eq true
    end

    it "parses 01:45:33 as a 105 minute duration" do
      expect(subject.parse("01:45:33").minutes).to eq 105
    end

    it "parses 1:02:30 as 62 minutes" do
      duration = Duration.parse("1:02:30")
      expect( duration.minutes ).to eq 62
    end
  end

  describe Duration::MinutesSecondsParser do
    it "can parse time formated as MM:SS" do
      expect(subject.can_parse("45:33")).to eq true
    end

    it "parses 45:33 as a 45 minute duration" do
      expect(subject.parse("45:33").minutes).to eq 45
    end

    it "parses 62:33 as a 62 minute duration" do
      expect(subject.parse("62:33").minutes).to eq 62
    end

    it "parses 59:00 as 59 minutes" do
      duration = Duration.parse("59:00")
      expect( duration.minutes ).to eq 59
    end
  end

  describe Duration::SecondsParser do
    it "can parse time formated as a number" do
      expect(subject.can_parse("120")).to eq true
    end

    it "parses 120 as a 2 minute duration" do
      expect(subject.parse("120").minutes).to eq 2
    end

    it "parses 120 as 2 minutes" do
      duration = Duration.parse("120")
      expect( duration.minutes ).to eq 2
    end
  end

  it "interacts with a parser to obtain a duration" do
    parser = double(:parser)
    expect(parser).to receive(:can_parse).with("120") { true }
    expect(parser).to receive(:parse).with("120")
    duration = Duration.parse("120", [parser])
  end
end

