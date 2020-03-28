require "stl_metrics/version"
require "stl_metrics/parser"
require "stl_metrics/geometry_utils"

module StlMetrics
  class Error < StandardError; end

  # parses a .stl file at +file_name+ and returns an instance of +StlMetrics::MetricsInfo+
  def self.parse_file(file_name, options = {})
    parser = Parser.new(file_name, options)

    #vertex_store = SimpleVertexStore.new
    facet_store = MemoryInefficientFacetStore.new()

    parser.on_solid_name do |name|
      puts "Solid name: #{name}"
    end

    parser.on_triangle do |triangle|
      facet_store.add_facet(triangle)
    end

    parser.parse!

    total_triangles = facet_store.total_facets
    puts "total triangles: #{total_triangles}"

    total_surface_area = 0

    facet_store.each do |triangle|
      surface_area = GeometryUtils.calculate_3d_surface_area(triangle)
      total_surface_area += surface_area
    end

    puts "total surface area: #{total_surface_area}"
  end



  # Stores all of the triangles with their coordinates
  # and doesn't try to remove duplicate coordinates.
  # Thus, there's a lot of duplicated data in here.
  class MemoryInefficientFacetStore
    attr_accessor :facets

    def initialize
      @facets = []
    end

    def add_facet(facet)
      @facets << facet
    end

    def total_facets
      @facets.length
    end

    def each(&block)
      @facets.each(&block)
    end
  end

  #class HashIndexedVertexStore
  #  def initialize
  #    @index = {}
  #  end

  #  def find_or_create_vertex(x, y, z)
  #    @index[x] ||= {}
  #    @index[x][y] ||= {}
  #    @index[x][y][z] ||= {}
  #  end

  #  def get_vertex(x, y, z)
  #  end
  #end

  #class SimpleVertexStore
  #  def initialize
  #    @index = []
  #  end
  #end

end
