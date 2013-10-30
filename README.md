# Sequel::Devise

Allows the usage of a Sequel::Model class as a Devise mapping.

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-devise'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-devise

## Usage

    class User < Sequel::Model
        plugin :devise
        devise :database_authenticatable
    end

If you're interested in more instructions on using Sequel with Rails,
I've written [some instructions](http://rosenfeld.herokuapp.com/en/articles/2012-04-18-getting-started-with-sequel-in-rails) in my web site.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/rosenfeld/sequel-devise/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

