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

### Method: `failure_message(name, message)`

The `failure_message` method allows a message to be registered with a specific name and a message associated with that name. 

`failure_message name, message`

The `name` should be symbol which represents a reason for failure.

The `message` can either be a string containing the failure message, or a lambda (proc) that returns a string with the message.

```ruby
RSpec::GraphQLResponse.add_validator :some_validator do
  failure_message :a_failure, "Failed because of a failure"

  # ...
end
```

Providing a lambda for the message allows the message to receive parameters and format the message using those parameters.

```ruby
RSpec::GraphQLResponse.add_validator :some_validator do
  failure_message :wrong_value, ->(value) { "Failed because #{value} is not 'foo'" }

  # ...
end
```

The failure messages can be referenced in the validation methods by calling `fail_validation` (see below)

### Method: `validate(&validation_block)`

Provide a validation method to determine if the actual value meets expectations. This validation method is most commonly
used with the `expect(something).to ...` RSpec matcher syntax.

The `&validation_block` will receive the actual value to validate as well as any other parameters that may need to be defined.
There are no limitations on the number of parameters or their names.

```ruby
RSpec::GraphQLResponse.add_validator :some_validator do
  # ... failure_messages and other bits

  validate do |actual, some_value|
    # ... validation logic here

    next fail_validation(:reason) if some_failure_criteria
  end
end
```

### Method: `validate_negated(&validation_block)`

Provide a negated validation method to determine if the actual value meets expectations. This validation method is
most commonly used with the negated expecation syntax, such as `expect(something).to_not ...`.

The `&validation_block` will receive the actual value to validate as well as any other parameters that may need to be defined.
There are no limitations on the number of parameters or their names.

```ruby
RSpec::GraphQLResponse.add_validator :some_validator do
  # ... failure_messages and other bits

  validate_negated do |actual, some_value|
    # ... negated validation logic here

    next fail_validation(:reason) unless some_failure_criteria
  end
end
```

Remember that `negated` validation should prove that the specified condition does _not_ exist. For example, when writing
an expectation such as `expect(response).to_not have_errors`, the `validate_negated` method needs to verify that there are
no errors in the response.

```ruby
validate_negated do |response|
  errors = response.fetch("errors", [])

  # check for the negation of have_errors, meaning check to 
  # make sure there are no errors
  next fail_validation(:found_errors) unless errors.count == 0
end
```

### Validation Failure

When the actual value does not reflect any expected value, a failure can be noted by calling `next failure_message(name, [values])`.

The `name` is a symbol which has been registered using the `failure_message` method (see above). And `[values]` are an optional
array of values that will be provided to the failure message if the registered message is a lambda (proc).

```ruby
vadliate do |actual|

  # something went wrong, better fail!
  next fail_validation(:bad_thing) if actual.bad_value
end
```

**IMPORTANT NOTE**

There can be only _one_ valid reason for failure at a time. Therefore, as soon as a failure condition is met, the `fail_validation`
method should be invoked. Then to prevent the rest of the method from executing, the `validate` or `validate_negates` method should
be halted immediately. Due to the syntax requirements of ruby lambdas and procs, this is done with the `next` keyword.

So be sure to call `next failure_message ...` and not just `failure_message`!

### Validation Success

If all validation checks pass, the final call in the `validate` or `validate_negated` methods should be `pass_validation`

```ruby
validate do |actual|
  # ... check for failed conditions

  # everything passed!
  pass_validation
end
```

The `pass_validation` method takes in no parameters, as a valid result does not provide a reason.
