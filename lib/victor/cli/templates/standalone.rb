require "victor"

svg = Victor::SVG.new %{attributes}
svg.build do
  %{nodes}
end

svg.save "generated"
