# Render this template by running 'ruby FILE' or 'victor to-svg FILE'

require "victor/script"

setup a: "b"

build do
  rect x: 10
end

puts render
save "output"
