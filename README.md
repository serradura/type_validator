[![Build Status](https://travis-ci.com/serradura/type_validator.svg?branch=master)](https://travis-ci.com/serradura/type_validator)

# TypeValidator

Adds type validation for classes with [`ActiveModel::Validations >= 3.2`](https://api.rubyonrails.org/classes/ActiveModel/Validations.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'type_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install type_validator

## Usage

Use one or all of the type validations into your models/classes:

```ruby
validates :name, type: { is_a: String }
# or
validates :name, type: { kind_of: String }

# Use an array to verify if the attribute is an instance of one of the classes

validates :status, type: { is_a: [String, Symbol]}
# or
validates :status, type: { kind_of: [String, Symbol]}
```

```ruby
validates :handler, type: { respond_to: :call }
```

```ruby
# Verifies if the attribute value is the class or a subclass.

validates :handler, type: { klass: Handler }
```

```ruby
validates :account_types, type: { array_of: String }

# or use an array to verify if the attribute is an instance of one of the classes

validates :account_types, type: { array_of: [String, Symbol] }
```

```ruby
# Verifies if the attribute value is an array with some or all the expected values.

validates :account_types, type: { array_with: ['foo', 'bar'] }
```

**All the validations above accept:**
- `allow_nil` option. e.g:. e.g:
    ```ruby
    validates :name, type: { is_a: String }, allow_nil: true
    ```
- `strict: true` option or the usage of `validates!`method. e.g:
    ```ruby
    validates :name, type: { is_a: String }, strict: true
    #or
    validates! :name, type: { is_a: String }
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/serradura/type_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TypeValidator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/serradura/type_validator/blob/master/CODE_OF_CONDUCT.md).
