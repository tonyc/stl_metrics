# Stores all of the triangles with their coordinates
# and doesn't try to remove duplicate coordinates.
# Thus, there's a lot of duplicated data in here.
class MemoryInefficientFacetStore
  include Enumerable

  attr_accessor :facets

  def initialize
    @facets = []

    @max_x = @max_y = @max_z = -Float::INFINITY
    @min_x = @min_y = @min_z = Float::INFINITY
  end

  def add_facet(facet)
    calculate_new_min_maxes!(facet)

    @facets << facet
  end

  def total_facets
    @facets.length
  end

  def calculate_bounding_box!
    coords = []
    
    x_coords.each do |x|
      y_coords.each do |y|
        z_coords.each do |z|
          coords << [x, y, z]
        end
      end
    end

    coords
  end

  # for Enumerable
  def each(&block)
    @facets.each(&block)
  end

  private
  def calculate_new_min_maxes!(facet)
    # min/maxes for new bounding box
    xs = facet.map { |f| f[0] }
    ys = facet.map { |f| f[1] }
    zs = facet.map { |f| f[2] }

    x_min, x_max = xs.min, xs.max
    y_min, y_max = ys.min, ys.max
    z_min, z_max = zs.min, zs.max

    # figure out new mins
    @min_x = x_min if x_min < @min_x
    @min_y = y_min if y_min < @min_y
    @min_z = z_min if z_min < @min_z

    # figure out new maxes
    @max_x = x_max if x_max > @max_x
    @max_y = y_max if y_max > @max_y
    @max_z = z_max if z_max > @max_z
  end

  def x_coords
    [@min_x, @max_x]
  end

  def y_coords
    [@min_y, @max_y]
  end

  def z_coords
    [@min_z, @max_z]
  end


end

