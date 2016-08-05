# OpenGraphy  [![Build Status](https://travis-ci.org/onthebeach/open_graphy.svg)](https://travis-ci.org/onthebeach/open_graphy) [![Gem Version](https://badge.fury.io/rb/open_graphy.svg)](http://badge.fury.io/rb/open_graphy)

This ruby gem allow you to fetch data that follows the opengraph protocol, and lets you fetch data from custom metatags also.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_graphy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_graphy

## Usage

Firstly require the gem using:
```ruby
require 'open_graphy'
```

To fetch opengraph data from a URL use:
```ruby
movie = OpenGraphy.fetch("https://www.rottentomatoes.com/m/coffee_and_cigarettes/")
```
The fetch method returns an object with methods defined that can be used to access the data retrieved. A is also defined so you can check the existence of data before using it.
```ruby
movie.title #=> "Coffee and Cigarettes"
movie.image? #=> true
movie.image #=> "https://resizing.flixster.com/9l1s-frU7dhkYqr0V-C0AlDpJuU=/740x290/v1.bjs3MDg4NTg7ajsxNzA2MzsxMjAwOzEyODA7NzIw"
movie.type #=> "video.movie"
```

## Configuration
By default the gem is set to look for og metatags.
To fetch data from custom metatags you can configure the gem, the example below shows a typical configuration.

```ruby
OpenGraphy.configure do |config|
  config.metatags = ["og:", "custom:tag:",]
end
```

When fetching data the default useragent is `OpenGraphyBot`, the example below shows a custom user agent being set.

```ruby
OpenGraphy.configure do |config|
  config.user_agent = 'DataBot/0.6'
end
```

## Copyright

Copyright (c) 2016 OnTheBeach Ltd. See LICENSE.txt for further details.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/open_graphy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
