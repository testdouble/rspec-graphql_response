# Adding Helper Methods with `.add_helper`

Much of the value that RSpec::GraphQLResponse brings is in the form of helper methods. Some helpers
will let you simplify a spec from a verbose set of structure parsing, like this:

```ruby
it "does stuff" do
  characters = response["data"]["characters"]

  expect(characters).to include(
    ...
  )
end
```

Down into something a little more reasonable with the `operation` helper, like this:

```ruby
it "does stuff" do
  expect(operation(:characters)).to include(
    ...
  )
end
```

It's not a huge difference, but when you consider how well the `operation` method handles `nil` and 
operation results that are not found, it's well worth the few lines of savings.

There are many other helpers available for your test suites, as well. Be sure to check the full
documentation list in the main readme.

## Add a Spec Helper

Most of the helpers that you'll want to add will be methods that are made available inside of
your `it` (and related / similar) blocks, as shown above.

To do this, you only need to call `RSpec::GraphQLResponse.add_helper(name, &helper_block)`. The `name` should
be a symbol that represents the method name you wish to create. And the `&helper_block` is the actual
method body, with any params you need.

Within the helper body, you will have access to all available features of RSpec's `it` blocks, including
other helper methods that come with RSpec::GraphQLResponse.

A simple example can be found in the `operation` helper:

```ruby
RSpec::GraphQLResponse.add_helper :operation do |operation_name|
  return nil unless response.is_a? Hash

  response.dig("data", operation_name)
end
```

In this example, the `response` helper is used, which guarantees the graphql has been executed and a response 
is available, assuming there were no exceptions preventing that.

## Add a Context Helper

In addition to Spec level helpers, RSpec::GraphQLResponse allows you to add custom helpers at the context
level. This means you can add configuration and other bits that can be called outside of an `it` block.
The existing `graphql_query` and other DSL methods for configuring graphql calls are a great example of
context level helpers.

To create a context helper, call `RSpec::GraphQLResponse.add_context_helper(name, &helper_block)`. The params
are the same as `.add_helper`, but the resulting method will be made available in `describe` and `context`
blocks.

```ruby
RSpec::GraphQLResponse.add_context_helper :my_setting do |some_arg|
  @my_setting = some_arg
end
```

In this simple example, a method called `my_setting` is created, and it stores a value in the instance variable
`@my_setting`. This takes advantage of RSpec's native ability to handle instance variables in describe and
context blocks, allowing the variable to exist withing the hierarchy of objects for a given spec. 

With that defined, it can be used within a spec:

```ruby
RSpec.describe Cool::Thing, type: :graphql do

  my_setting "this is a cool setting!"


  it "has the setting" do
    setting = self.class.instance_variable_get(:@my_setting)

    expect(setting).to eq("this is a cool setting!")
  end
end
```

You may want to provide a better way of retrieving the `@my_setting` var from the class, but this at least
demonstrates the ability to retrieve it from the class created by the `describe` block.
