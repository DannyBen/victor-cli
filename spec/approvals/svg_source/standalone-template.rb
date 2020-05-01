# Render this template by running 'ruby FILE' or 'victor render FILE'

require "victor"

svg = Victor::SVG.new a: "b"
svg.build do
  rect x: 10
end

svg.save "generated"
