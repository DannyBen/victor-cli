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

### `init`: Create a sample Ruby file

Run this command to create an initial sample file:

```shell
$ victor init example
```

### `render`: Render Ruby to SVG

Given this Ruby code:

```ruby
# example.rb
setup width: 140, height: 100

build do
  circle cx: 50, cy: 50, r: 30, fill: "yellow"
end
```

Run this command:
```shell
$ victor render example.rb --template minimal
```

To generate this code:

```xml
<svg width="140" height="100">
  <circle cx="50" cy="50" r="30" fill="yellow"/>
</svg>
```

### `convert`: Convert SVG to Ruby

Given this SVG file:

```xml
<!-- example.svg -->
<svg width="140" height="100">
  <circle cx="50" cy="50" r="30" fill="yellow"/>
</svg>
```

Run this command:

```shell
$ victor convert example.svg
```

To generate this Ruby code:

```ruby
setup width: "140", height: "100"

build do
  circle cx: "50", cy: "50", r: "30", fill: "yellow"
end

```
---

[victor]: https://github.com/DannyBen/victor
