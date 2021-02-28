# Adding Validators

Adding your own matcher is well [documented by the RSpec project](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/custom-matchers/define-a-custom-matcher).
What this documentation doesn't cover, however, is unit testing and cleanly
organizing your matcher code. 

To solve this, RSpec::GraphQLResponse introduced validators - code that is
called to manage the validation of a graphql response, and provide the failure
messages. 


## Clean Matchers with Validators

Validators allow your code to be well organized, and unit tested,
while providing a clean implementation of the matcher, as shown here:

```ruby
RSpec::GraphQLResponse.add_matcher :foo_bar do |expected_value)
  match do |actual_value|
    foo_bar = RSpec::GraphQLResponse.validator(:foo_bar)

    @result = foo_bar.validate(actual_value, expected_value)
  end

  failure_message do |response|
    @result.reason
  end
end
```

## Add a Validator with a Failure Message

```ruby
RSpec::GraphQLResponse.add_validator :foo_bar do
  # a regular failure message named `:nil`
  failure_message :nil, "Can't validate nil"

  # a lambda failure message named `:not_foo`
  # this lets you pass data to the message so it can
  # be more expressive of the failure reason
  failure_message :not_foo, -> (actual, expected) { "Expected it to #{actual}, but it did not. found #{expected}" }
  
  validate do |actual, expected|
    # fail for one reason
    next fail_validation(:nil) if actual.nil?

    # fail for another reason, with data passed
    # to the failure message
    next fail_validation(:not_foo, actual, expected) unless actual == expected

    # no failures found, so pass it!
    pass_validation
  end
end
```

### Method: `failure_message`

The `failure_message` method allows a message to be registered with a specific name. 
