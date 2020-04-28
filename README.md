# Victor CLI

[![Gem Version](https://badge.fury.io/rb/victor-cli.svg)](https://badge.fury.io/rb/victor-cli)
[![Build Status](https://github.com/DannyBen/victor-cli/workflows/Test/badge.svg)](https://github.com/DannyBen/victor-cli/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/ab7a46b42d268e374ee1/maintainability)](https://codeclimate.com/github/DannyBen/victor-cli/maintainability)

---

Command line interface for [Victor][victor], the SVG Library.

---

## Installation

    $ gem install victor-cli

## Usage

### Convert SVG to Ruby

Given this SVG file:

```xml
<!-- example.svg -->
<svg width="140" height="100">
  <circle cx="50" cy="50" r="30" fill="yellow"/>
</svg>
```

Run this command:

```shell
$ victor to-ruby example.svg
```

To generate this Ruby code:

```ruby
require "victor"

svg = Victor::SVG.new width: "140", height: "100"
svg.build do
  circle cx: "50", cy: "50", r: "30", fill: "yellow"
end

svg.save "generated"
```

### Convert Ruby to SVG

Given this Ruby code:

```ruby
# example.rb
svg.setup width: "140", height: "100"

svg.build do
  circle cx: "50", cy: "50", r: "30", fill: "yellow"
end
```

Run this command:
```shell
$ victor to-svg example.rb --template minimal
```

To generate this code:

```xml
<svg width="140" height="100">
  <circle cx="50" cy="50" r="30" fill="yellow"/>
</svg>
```

---

[victor]: https://github.com/DannyBen/victor
