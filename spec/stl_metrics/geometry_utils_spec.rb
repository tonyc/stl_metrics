RSpec.describe StlMetrics::GeometryUtils do

  describe "calculate_3d_surface_area" do
    let(:result) {
      StlMetrics::GeometryUtils.calculate_3d_surface_area(triangle)
    }

    describe "a basic triangle" do
      let(:triangle) {
        [
          [0, 0, 0],
          [1, 0, 0],
          [1, 1, 1],
        ]
      }

      it "calculates the area correctly" do
        expect(result).to be_within(0.001).of(0.70710)
      end
    end

    describe "another triangle" do
      let(:triangle) {
        [
          [-5, 5, -5],
          [1, -6, 6],
          [2, -3, 4]
        ]
      }

      it "calculates the area" do
        expect(result).to be_within(0.001).of(19.3067)
      end
    end
  end

end
