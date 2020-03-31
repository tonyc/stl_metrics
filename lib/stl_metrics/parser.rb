require 'bigdecimal'

module StlMetrics
  class Parser
    attr_reader :file_name
    attr_reader :solid_name

    def initialize(file_name, options = {})
      @file_name = file_name
      @options = options

      @solid_name = nil

      @vertices = []

      # callbacks for solid_name and triangle
      @solid_block = nil
      @triangle_block = nil
    end

    def on_solid_name(&block)
      @solid_block = block
    end

    def on_triangle(&block)
      @triangle_block = block
    end

    def parse!
      File.foreach(file_name) do |line|

        # This block of code could maybe benefit from a state machine-type setup,
        # (particularly for error checking), but since we can assume the sample files
        # are always properly formed, we can take a simpler approach of just
        # scanning the current line and building up vertices.

        # only check for the solid name if we don't already have it
        if !solid_name && md = /\Asolid (\w+)/.match(line)
          @solid_name = md[1]
          @solid_block.call(@solid_name) if @solid_block
        elsif md = /vertex (.*)/.match(line)
          md = /vertex (.*)/.match(line)
          coordinates = md[1].split(" ").map(&:to_f)
          #coordinates = md[1].split(" ").map { |coord| BigDecimal(coord) }

          cache_vertex(coordinates)
        elsif md = /endloop/.match(line)
          finalize_triangle
        else
          # nothing
        end
      end
    end

    private
    def cache_vertex(vertex)
      @vertices << vertex
    end

    def finalize_triangle
      @triangle_block.call(@vertices) if @triangle_block
      reset_vertices!
    end

    def reset_vertices!
      @vertices = []
    end
  end
end
