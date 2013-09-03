# Etat

Etat is a minimalistic gem to help you (me, for now) manage some states in your app. It is built for Rails 4 and assumes the use of ActiveRecord 4. See the 'usage' section for more.

Etat means "State" in French.

[![Gem Version](https://badge.fury.io/rb/etat.png)](http://badge.fury.io/rb/etat)
[![Build Status](https://travis-ci.org/jipiboily/etat.png?branch=master)](https://travis-ci.org/jipiboily/etat)
[![Code Climate](https://codeclimate.com/github/jipiboily/etat.png)](https://codeclimate.com/github/jipiboily/etat)

## Installation

Add this line to your application's Gemfile:

    gem 'etat'

And then execute:

    $ bundle

## Usage

```ruby
class MyModel < ActiveRecord::Base
  has_states :draft, :published, :deleted
  event :publish do
    # some code to happen on publish...
    self.state = :publish
    self.save!
  end
end
```

Etat will generate a few methods and scopes that will help you:

- `MyModel.states` will give you an array of the states. # [:draft, :published, :deleted]
- `MyModel.all_published`: scope that will return all records with that state (and equivalents - for each states).
- `MyModel.all_but_published`: scope that will return all records except the ones with that state (and equivalents for each states).
- `my_model_instance.state`: it will return the current state, as a symbol, always.
- `my_model_instance.published?`: boolean. Will tell you if current record has that state or not (and equivalents for each states).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request