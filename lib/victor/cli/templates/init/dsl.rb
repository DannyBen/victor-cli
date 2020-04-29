# Render this by running
# ruby "%{filename}"
require 'victor/script'

setup viewBox: "0 0 100 100"

build do
  circle cx: 50, cy: 50, r: 40, fill: 'yellow'
  rect x: 10, y: 50, width: 80, height: 50, fill: 'yellow'

  [25, 50].each do |y|
    circle cx: y, cy: 40, r: 8, fill: 'white'
  end

  path d: "M11 100 l13 -15 l13 15 l13 -15 l13 15 l13 -15 l13 15 Z", fill: 'white'
end

puts render
save "ghost"