require "stl_metrics/version"
require "stl_metrics/parser"

module StlMetrics
  class Error < StandardError; end

  # parses a .stl file at +file_name+ and returns an instance of +StlMetrics::MetricsInfo+
  def self.parse_file(file_name)
    parser = Parser.new(file_name)
    parser.parse!
  end

  #class FacetStore
  #  attr_accessor :facets

  #  def initialize
  #    @facets = []
  #  end

  #  def add_facet(facet)
  #    @facets << facet
  #  end

  #  def total_facets
  #    @facets.length
  #  end
  #end

  #class VertexStore
  #  def initialize
  #    @index = {}
  #  end

  #  def find_or_create_vertex(x, y, z)
  #    @index[x] ||= {}
  #    @index[x][y] ||= {}
  #    @index[x][y][z] ||= {}
  #  end
  #end

end
