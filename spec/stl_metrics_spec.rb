RSpec.describe StlMetrics do
  describe "two_triangles.stl" do
    let(:filename) { "data/two_triangles.stl" }

    it "parses the file without error" do
      expect {
        StlMetrics.parse_file(filename)
      }.to_not raise_error
    end

    it "parses the solid name correctly" do
      result = StlMetrics.parse_file(filename)
    end
  end

  describe "Moon.stl" do
    let(:filename) { "data/Moon.stl" }

    it "parses the file without error" do
      expect {
        StlMetrics.parse_file(filename)
      }.to_not raise_error
    end

    it "parses the solid name correctly" do
      result = StlMetrics.parse_file(filename)
    end
  end

end
