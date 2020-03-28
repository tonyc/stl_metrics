# stl_metrics

This is a basic .stl file parser and metrics calculator.

## Requirements

* Ruby 2.x.x (use asdf, rvm, or your favorite ruby version manager)

## Setup

Check out the repo, and run `bundle install`

## Usage

```bash
bundle exec ruby display_metrics.rb data/Moon.stl
```

## Ruby/API Usage

```ruby
metrics = STLMetrics.parse_file("Moon.stl")

metrics.total_triangles()
# => 116

metrics.calculate_surface_area()
# => 14.235

metrics.calculate_minimum_bounding_box()
# => [[x,y,z] ... ] # list of 8 [x,y,z] coordinates
```

## Running tests

```bash
bundle exec rspec
```
