# Render this template by running 'victor render FILE'

build do
  css["*"] = {
    fill: "yellow",
  }

  css[".main"] = {
    stroke: "green",
    stroke_width: 2,
    opacity: 0.7,
  }

  text "without attributes"

  text "with attributes", x: 10, y: 10

  text x: 10, y: 10 do
    _ "with"

    tspan "block", font_weight: "bold"

    _ "and attributes"
  end
end
