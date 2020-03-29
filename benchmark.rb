require "stl_metrics"
require "benchmark/ips"

raise ArgumentError, "Please supply a file name" unless filename = ARGV[0]
raise ArgumentError, "File doesn't exist: #{filename}" unless File.exist?(filename)

puts "Benchmarking #{filename}"

#puts Benchmark.measure {
#  10_000.times do
#    result = StlMetrics.parse_file(filename)
#    total_facets = result.total_facets
#    surface_area = result.surface_area

#    true
#  end
#}


Benchmark.ips do |x|
  x.warmup = 15
  x.time = 60

  x.report("Parsing file") { 
    StlMetrics.parse_file(filename)
  }

  x.report("Parse file with surface area") { 
    result = StlMetrics.parse_file(filename)
    result.surface_area
  }

  x.compare!
end
