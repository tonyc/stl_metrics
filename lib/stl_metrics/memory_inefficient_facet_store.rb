# Stores all of the triangles with their coordinates
# and doesn't try to remove duplicate coordinates.
# Thus, there's a lot of duplicated data in here.
class MemoryInefficientFacetStore
  include Enumerable

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

