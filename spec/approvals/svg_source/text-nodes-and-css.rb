# Render this template by running 'victor render FILE'

setup

build do
  style type: "text/css" do
    _ ".main {\n        stroke: green;\n      }"
  end

  text do
    _ "without attributes"
  end

  text x: 10, y: 10 do
    _ "with attributes"
  end

  text x: 10, y: 10 do
    _ "with"
    tspan font_weight: "bold" do
      _ "block"
    end

    _ "and attributes"
  end
end
