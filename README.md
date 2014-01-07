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
  
  # define an event. The name of the even has nothing to do with the names of states. It could be `event 'do_whatever_you_want' { puts 'OK!' } `
  event :publish do
    # some code to happen on publish...
    self.state = :published
    self.save!
  end
end


instance = MyModel.new(state: :draft)
instance.draft? # true
instance.publish
instance.draft? # false
instance.published? # true
```

You can declare your states with `has_states` in your model. See the example above.

You can also create events that can be called, manually. They are basically the same as creating methods right now. In the example above, `event :publish` will create an instance method called `publish`. That's it. This is just for code clarity; we know it is related to states. Again, just to be clear, it won't be called automatically.

Etat will also generate a few more methods and scopes that will help you:

- `MyModel.states` will give you an array of the states. # [:draft, :published, :deleted]
- `MyModel.all_published`: scope that will return all records with that state (and equivalents - for each states).
- `MyModel.all_but_published`: scope that will return all records except the ones with that state (and equivalents for each states).
- `my_model_instance.state`: it will return the current state, as a symbol, always.
- `my_model_instance.published?`: boolean. Will tell you if current record has that state or not (and equivalents for each states).

## TODO
Here are a few things that could be useful, PRs are welcome!

- inject `Etat::ActiveRecord` into `ActiveRecord::Base` automatically instead of having to `include Etat::ActiveRecord` (planned)
- default_state :draft (planned)
- callbacks
  - before_state :some_state, :do_whatever
  - after_state :some_other_state, :do_whatever_else
  - around_state :yet_another_state, :lets_do_stuff

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jipiboily/etat/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

