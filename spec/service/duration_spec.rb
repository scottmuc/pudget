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
end
