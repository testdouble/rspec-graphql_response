# Using the `have_errors` Matcher

The `have_errors` matchers will verify the presence of errors in a graphql
execution's response. This matcher provides both `.to` and `.not_to` matching
and messages for all options.

## Basic Use

Check for the presence of `response["errors"]`

```ruby
it "should have errors" do
  expect(response).to have_errors
end
```

Ensure there are no errors in the `response`

```ruby
it "should not have errors" do
  expect(response).not_to have_errors
end
```

## Specify Error Count

Check for a specific number of errors, and fail if the response does not have
that number of errors.

```ruby
it "should have 3 errors" do
  expect(response).to have_errors(3)
end
```

Ensure the response does not have a specific number of errors.

```ruby
it "should not have 2 errors" do
  expect(response).not_to have_errors(2)
end
```

### CAUTION: False Positives

Using `.to have_errors(count)` and especially using `.not_to have_errors(count)` is
potentially dangerous! 

Your test may be ensuring there are not 2 errors, but the underlying code may fail
for an unknown reason and provide a false positive, saying the test passed because
there was only one error.

## Specify Error Messages

When checking for errors, it's best to check for specific messages. This ensures
the errors are what you expected and not something else, helping to prevent
false positives in your tests.

### Verify Specific Message

```ruby
it "raises User not found" do
  expect(response).to have_errors.with_messages("User not found")
end
```

This will ensure the `response["errors"]` contains a "User not found" error message.

### Ensure Specifed Error Not Found

```ruby
it "does not raise User not found" do
  expect(response).not_to have_errors.with_messages("User not found")
end
```

### Fails if Specified Error Found in Array

The `.not_to` form of `.with_messages` will ensure that none of the error messages
specified are found withing the response.

If, for example the response looks like this:

```
{
  "errors" => [
    {"message" => "User not found"},
    {"message" => "Invalid ID format"}
  ]
}
```

a test like this would fail:

```ruby
it "looks for specific errors" do
  expect(response).not_to have_errors.with_messages("User not found", "Some other errors")
end
```

The resulting failure message would state that it was expecting not to find the
"User not found" message, but it was found. The other non-matching error
messages would be ignored.

### CAUTION: False Positives

Using `.not_to have_errors.with_messages("Some Message")` is a good way to
ensure your code is not throwing a specific error message. However, it should
not be the only expectation against the response. If your code raises any errors
other than the ones specified, it will result in a passing test but a response
that still contains errors.

## Combining Count and Specified Messages

The above count and specified messages can be combined in some interesting and
potentially useful ways. 

### Check for a Count with a Message

```ruby
it "does interesting things" do
  expect(response).to have_errors(1).with_messages("User not found")
end
```

This example will ensure there is only 1 error, and that it is "User not found".
This is by far the most accurate way to check for errors, using this matcher.
