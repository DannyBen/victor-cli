svg.setup width: "140", height: "100", style: "background:#ddd"

svg.build do
  rect x: "10", y: "10", width: "120", height: "80", rx: "10", fill: "#666"
end

# No good
svg = "not Victor::SVG"
