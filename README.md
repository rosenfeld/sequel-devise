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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
