# Adding RSpec Matchers

RSpec::GraphQLResponse provides a thin layer around RSpec's native `matcher`
syntax to ensure the matchers you are adding will be included correctly.

This is usefurl whether you are developing new matchers to be included in
this gem directly, or adding them to your application for your specific needs.

## RSpec::GraphQLResponse.add_matcher

To add a new matcher, call `RSpec::GraphQLResponse.add_matcher`.

```ruby
RSpec::GraphQLResponse.add_matcher do |some_option|
  # ... this is a standard RSpec `matcher` block
  # where you can do anything you would do in RSpec

  match :foo_bar do
    # do your validation here
  end
end
```

This call is only a wrapper around RSpec's `matcher`. For information on how to
build your matcher, see the [RSpec project documentation](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/custom-matchers/define-a-custom-matcher).

## Combined with a Custom Validator

RSpec::GraphQLResponse provides a means of keeping your matcher code clean while
also making it easy to unit test the logic and messages supplied from the
matcher, using [RSpec::GraphQLResponse.add_validator](/docs/add_validator.md).

Once a validator has been created, it can be called from a matcher.

```ruby
RSpec::GraphQLResponse.add_matcher :foo_bar do
  match do |response|
    have_errors = RSpec::GraphQLResponse.validator(:foo_bar)
    @result = have_errors.validate
  end

  failure_message do |response|
    @result.reason
  end
end
```

For information on creating a valdator, see the [add validators documentation](/docs/add_validator.md).
