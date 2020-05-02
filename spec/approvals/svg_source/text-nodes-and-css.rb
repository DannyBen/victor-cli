# Render this template by running 'victor render FILE'

setup

build do
  style type: "text/css" do
    _ ".main {\n        stroke: green;\n      }"
  end

  text "without attributes"
  text "with attributes", x: 10, y: 10
  text x: 10, y: 10 do
    _ "with"
    text "block", font_weight: "bold"
    _ "and attributes"
  end
end
