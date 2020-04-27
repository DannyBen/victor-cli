# Victor CLI

[![Gem Version](https://badge.fury.io/rb/victor-cli.svg)](https://badge.fury.io/rb/victor-cli)
[![Build Status](https://github.com/DannyBen/victor-cli/workflows/Test/badge.svg)](https://github.com/DannyBen/victor-cli/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/a5fa93e41f935e3148a9/maintainability)](https://codeclimate.com/github/DannyBen/victor-cli/maintainability)

---

Command line interface for Victor, the SVG Library.

---

## Installation

    $ gem install victor-cli


## Usage

```
$ victor generate --help
Generate Ruby code from SVG

Usage:
  victor generate SVG_FILE [RUBY_FILE]
  victor generate (-h|--help)

Options:
  -h --help
    Show this help

Parameters:
  SVG_FILE
    Input SVG file

  RUBY_FILE
    Output Ruby file. Leave empty to write to stdout

Examples:
  victor generate example.svg example.rb

```