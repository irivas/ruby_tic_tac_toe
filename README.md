[![Build Status](https://travis-ci.org/matthewglover/ruby_tic_tac_toe.svg)](https://travis-ci.org/matthewglover/ruby_tic_tac_toe)

# Tic Tac Toe in Ruby

## What

A Tic Tac Toe Game in Ruby.

## Why

To learn Ruby and OOP principles.

## How

Clone the repo and install the dependencies by running `bundle install`.

Run `rspec` to run all the tests. Run `rspec -t ~speed:slow` to filter out slow tests 
(i.e. algorithm speed tests) 

Alternatively run `bundle exec guard` to automatically run the tests on file change (note: this
doesn't run tests tagged as `speed: 'slow'`.

Run `ruby tic_tac_toe.rb` to play game
