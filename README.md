# Project has moved

This project is no longer maintained in this repository.
Please head over to [ontohub/sequel-devise](https://github.com/ontohub/sequel-devise) for the current version.

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

## Important Note

Unfortunately Devise does not rely on the `orm_adapter` specs as 
[it was supposed to](https://github.com/plataformatec/devise/blob/master/devise.gemspec#L22).

It will assume the model support other methods besides those defined by `orm_adapter` and that they
behave like the equivalent in ActiveRecord supporting the same arguments.

In some cases, it will call some method which is not defined by `Sequel::Model`, so we implement
them in this gem, but there are some cases which are trickier. For example, Devise will call the
`save` method in the model and expect it to return false if the validation fails. This is not the
default behavior of Sequel::Model, so you'll have to change this behavior for your User classes
that are intended to be used by Devise. There are a few solutions depending on your use case:

Please make sure you take a look at the implementation to understand which methods are added
in order to support Devise. Particularly, for security reasons Devise will override inspect
so that it doesn't display passwords hashes for example among other keys. If you want the
original inspect, call `user.inspect(false)`.

### You expect your Sequel Models to not raise on save failure by default

Just disable the raise behavior by default:

    Sequel::Model.raise_on_save_failure = false

### You are okay with changing the raise behavior only for your user classes

    class User < Sequel::Model
      self.raise_on_save_failure = false
      plugin :devise
      devise :database_authenticatable
    end

### You don't want to touch your user model just to accomodate Devise

You are free to simply create another user class that is meant to be used by Devise while the
remaining of your application just use your regular user class:

    class DeviseUser < User
      self.raise_on_save_failure = false
      plugin :devise
      devise :database_authenticatable
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

