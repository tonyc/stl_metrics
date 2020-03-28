module StlMetrics
  class Parser
    attr_reader :file_name
    attr_reader :solid_name

    def initialize(file_name, options = {})
      @file_name = file_name
      @options = options

      @solid_name = nil

      @vertices = []
    end

    def parse!
      File.foreach(file_name) do |line|
        # This block of code could benefit from a state machine-type setup,
        # (particularly for error checking), but since we can assume the sample files
        # are always properly formed, we can take a simpler approach of just
        # scanning the current line and building up vertices.

        # only check for the solid name if we don't already have it
        if !solid_name && md = /\Asolid (\w+)/.match(line)
          store_solid_name(md[1])
        elsif md = /vertex (.*)/.match(line)
          coordinates = md[1].split(" ").map(&:to_f)

          store_vertex(coordinates)
        elsif md = /endloop/.match(line)
          finalize_triangle
        else
          # nothing
        end
      end
    end

    private
    def store_vertex(vertex)
      @vertices << vertex
    end

    def store_solid_name(name)
      @solid_name = name
    end

    def finalize_triangle
      # store the triangle
      #puts "finalize_triangle: #{@vertices.inspect}"

      reset_vertices!
    end

    def reset_vertices!
      @vertices = []
    end
  end
end
