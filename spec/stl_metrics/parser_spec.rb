RSpec.describe StlMetrics::Parser do
  let(:parser) { StlMetrics::Parser.new(filename) }

  describe "two_triangles.stl" do
    let(:filename) { "data/two_triangles.stl" }

    it "parses the file without error" do
      expect {
        parser.parse!
      }.to_not raise_error
    end

    it "parses the solid name correctly" do
      parser.parse!
      expect(parser.solid_name).to eq("simple")
    end
  end

  describe "Moon.stl" do
    let(:filename) { "data/Moon.stl" }

    it "parses the file without error" do
      expect {
        parser.parse!
      }.to_not raise_error
    end

    it "parses the solid name correctly" do
      parser.parse!
      expect(parser.solid_name).to eq("Moon")
    end
  end
end
