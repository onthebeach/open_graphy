# OpenGraphy

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
data = OpenGraphy.fetch("www.imdb.com/title/tt2084970/")
```
The fetch method returns an object which has methods that can be used to access the data retrieved. If there is data, false will be returned
```ruby
movie.title #=> "The Imitation Game (2014)"
movie.image #=> "http://ia.media-imdb.com/images/M/MV5BNDkwNTEyMzkzNl5BMl5BanBnXkFtZTgwNTAwNzk3MjE@._V1_.jpg"
movie.video #=> false
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
