require_relative '../../lib/services/string_parser'

describe StringParser do
  describe "#can_parse" do
    it "invokes invokes the proc it's constructed with" do
      can_parse = Proc.new { |string| true }
      parser = StringParser.new can_parse, double
      expect( parser.can_parse("test") ).to eq true
    end
  end

  describe "#parse" do
    it "invokes invokes the proc it's constructed with" do
      parse = Proc.new { |string| "test" }
      parser = StringParser.new double, parse
      expect( parser.parse("test") ).to eq "test"
    end
  end
end

