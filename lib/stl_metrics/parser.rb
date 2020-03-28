module StlMetrics
  class Parser
    attr_reader :file_name
    attr_reader :solid_name

    def initialize(file_name, options = {})
      @file_name = file_name
      @options = options

      @solid_name = ""

      @vertices = []
    end

    def parse!
      File.foreach(file_name) do |line|
        if md = /\Asolid (\w+)/.match(line)
          @solid_name = md[1]
        end

        if md = /vertex (.*)/.match(line)
          x, y, z = md[1].split(" ")
          store_vertex([x, y, z])
        end

        if md = /endloop/.match(line)
          finalize_triangle
        end
      end
    end

    private
    def store_vertex(vertex)
      @vertices << vertex
    end

    def finalize_triangle
      # store the triangle
      puts "finalize_triangle: #{@vertices.inspect}"

      reset_vertices!
    end

    def reset_vertices!
      @vertices = []
    end
  end
end
