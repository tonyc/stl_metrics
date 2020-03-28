require 'matrix'

module StlMetrics
  module GeometryUtils

    def self.calculate_3d_surface_area(triangle)
      p1, p2, p3 = *triangle

      a = Vector[*p1]
      b = Vector[*p2]
      c = Vector[*p3]

      ab = a - b
      ac = a - c

      return ab.cross_product(ac).magnitude / 2.0
    end
  end
end
