# stl_metrics

This is a basic .stl file parser and metrics calculator.

## Requirements

* Ruby 2.5.x (use asdf, rvm, or your favorite ruby version manager)

## Install ruby with asdf:
* https://asdf-vm.com/#/core-manage-asdf-vm
* Install asdf-ruby (https://github.com/asdf-vm/asdf-ruby): `asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`
* Install ruby: `asdf install ruby 2.5.1`

## Setup

Check out the repo, and run `bundle install`

## Usage

```bash
bundle exec ruby display_metrics.rb data/Moon.stl
```

## Benchmark
```bash
bundle exec ruby benchmark.rb data/Moon.stl
```

## Ruby/API Usage

```ruby
metrics = STLMetrics.parse_file("Moon.stl")

metrics.total_facets()
# => 116

metrics.surface_area()
# => 14.235

metrics.bounding_box()
# => [[x,y,z] ... ] # list of 8 [x,y,z] coordinates
```

## Running tests

```bash
bundle exec rspec
```

## Thoughts & Ideas

### Places & opportunities for modularity

It seemed that a good place for opportunity for modularity/replacement was to split the code across a few concerns:

* Parsing the text file (`StlMetrics::Parser`)
* Storing the data for the facets/triangles somewhere (`MemoryInefficientFacetStore`)
* Geometry-related calculations: surface area/bounding box/etc (`GeometryUtils`)

The main body of `StlMetrics::parse_file()` is fairly modular, and the `MemoryInefficientFacetStore` could easily be swapped out for another implementation, and likewise the use of `GeometryUtils` is in a fairly easy to change place. 

One way to make it even more extensible is to allow `parse_file()` to take a reference to the facet store, and a "geometry calculator" class/module, where the implementations could easily be swapped out via the `options` hash.

Late in the process, I realized the facet store didn't necessarily need to count the facets and accumulate the surface area as it went, so I changed it out, but perhaps the responsibility does indeed belong there. The advantage of this would be that the code could chop through the input file first, and then run the calculations as fast as possible without waiting for the callbacks (`on_solid_name`, `on_triangle`) to complete.

### Performance improvements

* There are a lot of places for performance improvements. Reading the file could be faster, and perhaps trying to read all of the points into memory, and then running the calculation on them, would be faster.
* C Ruby is also not known for being very fast on lots of calculations. This is a spot where the calculations (or the entire code) could be ported to something that would be better suited, perhaps JRuby, C, or Rust?
* Triangle area calculation could also be parallelized, which I didn't do.
* I did some simple benchmarking of C Ruby vs JRuby (see benchmark section, below)

### Other tidbits
I experimented with parsing the coordinates to BigDecimal objects, in order to keep precision, but it
slowed down parsing large files by about 100% :)

Without doing any computation on area, etc, simply parsing a 317M file with ~1.2M triangles takes about 10-13 seconds. Needless to say, C Ruby is not necessarily known for speed :)

I decided to punt on the 3d bounding box portion. This could easily go into `GeometryUtils`, or also be passed in to `StlMetrics::parse_file()` for modularity.

Another place for improvement would be a better facet store. Points shared between facets are currently duplicated, and memory usage could be reduced by keeping track of each point, and keeping a reference to that point, instead of just duplicating everything. (Hence the name `MemoryInefficientFacetStore`)

## Benchmark results: C Ruby 2.5.1 vs JRuby 9.2.9.0

* JRuby appears to be maybe 15% faster out of the box
* I didn't spend a lot of time tweaking JRuby. Lots of stuff could also be parallelized
* See `benchmark.rb` for script

### C Ruby 2.5.1

```
Benchmarking data/Moon.stl
Warming up --------------------------------------
        Parsing file   115.000  i/100ms
Parse file with surface area
                        74.000  i/100ms
Calculating -------------------------------------
        Parsing file      1.150k (± 1.0%) i/s -      5.750k in   5.000623s
Parse file with surface area
                        739.101  (± 1.6%) i/s -      3.700k in   5.007337s

Comparison:
        Parsing file:     1150.0 i/s
```

### JRUBY

```
Benchmarking data/Moon.stl
Warming up --------------------------------------
        Parsing file   109.000  i/100ms
Parse file with surface area
                        67.000  i/100ms
Calculating -------------------------------------
        Parsing file      1.427k (± 3.4%) i/s -      7.194k in   5.046766s
Parse file with surface area
                        832.035  (± 1.4%) i/s -      4.221k in   5.074193s

Comparison:
        Parsing file:     1427.2 i/s
Parse file with surface area:      832.0 i/s - 1.72x  slower
```

