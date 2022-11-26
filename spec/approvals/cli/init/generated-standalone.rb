# Render this by running
# ruby "spec/tmp/ghost.rb"
require 'victor'

svg = Victor::SVG.new viewBox: '0 0 100 100'

svg.build do
  circle cx: 50, cy: 50, r: 40, fill: 'yellow'
  rect x: 10, y: 50, width: 80, height: 50, fill: 'yellow'

  [25, 50].each do |x|
    circle cx: x, cy: 40, r: 8, fill: 'white'
  end

  path d: 'M11 100 l13 -15 l13 15 l13 -15 l13 15 l13 -15 l13 15 Z', fill: 'white'
end

puts svg.render
svg.save 'ghost'
