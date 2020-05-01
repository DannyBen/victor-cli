# Render this template by running 'ruby FILE' or 'victor render FILE'

require 'victor/script'

setup %{attributes}

build do
  %{nodes}
end

puts render
save 'output'