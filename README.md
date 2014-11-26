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

By default the gem is set to look for og metatags.
To fetch opengraph data from custom metatags you need to configure the gem. To do that use the following code which allows you to set an array of custom metatags and then fetch the url like below.
```ruby
OpenGraphy.configure do |config|
  config.metatags = ["og:", "custom:tag:",]
end
```

To fetch opengraph data from a URL then use:
```ruby
OpenGraphy.fetch("http://www.onthebeach.co.uk/hotels/")
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/open_graphy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
