RSpec.describe StlMetrics do
  let(:result) { StlMetrics.parse_file(filename) }

  describe "two_triangles.stl" do
    let(:filename) { "data/two_triangles.stl" }

    it "parses the file without error" do
      expect {
        result
      }.to_not raise_error
    end

    it "parses the solid name" do
      expect(result.solid_name).to eq("simple")
    end

    it "counts the facets" do
      expect(result.total_facets).to eq(2)
    end
  end

  describe "Moon.stl" do
    let(:filename) { "data/Moon.stl" }

    it "parses the file without error" do
      expect {
        result
      }.to_not raise_error
    end

    it "parses the solid name" do
      expect(result.solid_name).to eq("Moon")
    end

    it "counts the facets" do
      expect(result.total_facets).to eq(116)
    end
  end

  #describe "mandoblastersolid_ascii.stl", slow: true do
  #  let(:filename) { "data/mandoblastersolid_ascii.stl" }

  #  it "parses the file without error" do
  #    expect {
  #      result
  #    }.to_not raise_error
  #  end

  #  it "parses the solid name" do
  #    expect(result.solid_name).to eq("Uranium")
  #  end

  #  it "counts the facets" do
  #    expect(result.total_facets).to eq(1_281_429)
  #  end
  #end

end
