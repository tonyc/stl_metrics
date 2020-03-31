require "stl_metrics"

raise ArgumentError, "Please supply a file name" unless filename = ARGV[0]
raise ArgumentError, "File doesn't exist: #{filename}" unless File.exist?(filename)

puts "Parsing: #{filename}"
result = StlMetrics.parse_file(filename)

puts " Total facets: #{result.total_facets}"
puts " Surface area: #{result.surface_area}"
puts " Bounding box: #{result.bounding_box.inspect}"
