# Render this template by running 'ruby FILE' or 'victor render FILE'

require "victor"

svg = Victor::SVG.new %{attributes}
svg.build do
  %{nodes}
end

svg.save "generated"
