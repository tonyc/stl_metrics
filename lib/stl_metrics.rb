require "stl_metrics/version"
require "stl_metrics/parser"
require "stl_metrics/geometry_utils"
require "stl_metrics/memory_inefficient_facet_store"

module StlMetrics

  # parses a .stl file at +file_name+ and returns an instance of +StlMetrics::MetricsResult+
  def self.parse_file(file_name, options = {})
    parser = Parser.new(file_name, options)

    facet_store = MemoryInefficientFacetStore.new
    metrics_result = MetricsResult.new(facet_store: facet_store)

    parser.on_solid_name do |name|
      metrics_result.solid_name = name
    end

    parser.on_triangle do |triangle|
      facet_store.add_facet(triangle)
    end

    parser.parse!

    metrics_result
  end

  class MetricsResult
    attr_accessor :solid_name

    def initialize(options = {})
      @facet_store = options.fetch(:facet_store)

      @total_facets = nil
      @surface_area = nil
      @solid_name = nil
      @bounding_box = nil
    end

    def total_facets
      @total_facets ||= facet_store.total_facets
    end

    def surface_area
      @surface_area ||= compute_surface_area!
    end

    def bounding_box
      @bounding_box ||= compute_bounding_box!
    end

    private
    attr_reader :facet_store

    def compute_surface_area!
      facet_store.inject(0.0) do |total_area, facet|
        total_area += GeometryUtils.calculate_3d_surface_area(facet)
      end
    end

    def compute_bounding_box!
      # 3d bounding box calculation here ;)
      raise NotImplementedError
    end
  end

end
