module StlMetrics
  class MetricsInfo
    def initialize(options = {})
      @options = options
    end

    def total_triangles
      raise NotImplementedError
    end

    def calculate_surface_area
      raise NotImplementedError
    end

    def calculate_minimum_bounding_box
      raise NotImplementedError
    end
  end
end
