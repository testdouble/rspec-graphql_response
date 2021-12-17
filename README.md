# Rspec::GraphQLResponse

RSpec::GraphQLResponse provides a series of RSpec matchers, helper methods, and other configuration to help simplify
the testing of responses from the `graphql-ruby` gem and the `<GraphQLSchemaName>.execute` method.

## "Why Should I Use This?"

There are a number of built-in helper methods and matchers that will allow you to skip the copy & paste work of executing
a GraphQL Schema `.execute`. Additionally, there are custom matchers and other bits that will help simplify your work in
validating common peices of a graphql response.

Lastly, the work in this gem is geared toward customization for your own application's needs. Every API call used for building
the pieces of this gem are available to you, directly, in the `API / Development` documentation, below.

## Installation

Your app must have `graphql-ruby` and `rspec`. With that done, add this line to your application's Gemfile:

```ruby
gem 'rspec-graphql_response'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-graphql_response

## Full Documentation

- [Release Notes](/RELEASE_NOTES.md)
- [Upgrade Guide](/UPGRADE.md)

The full documentation for RSpec::GraphQLResponse can be found in the `/docs` folder.

Configuration:

- [RSpec::GraphQLResponse.configure](/docs/configuration.md)
- [Spec Type :graphql](/docs/graphql_spec_type.md)

Custom Matchers:

- [have_errors](/docs/have_errors.md) - validates errors, or lack of, on the GraphQL response
- [have_field](/docs/have_field.md) - validates the presence of a specified graphql operation in the graphql response

Context / Describe Helper Methods:

- [graphql_operation](/docs/execute_graphql.md) - the operation to execute (i.e query or mutation)
- [graphql_variables](/docs/execute_graphql.md) - a hash of variables the query expects
- [graphql_context](/docs/execute_graphql.md) - the `context` of a query or mutation's resolver

Spec Helper Methods:

- [execute_graphql](/docs/execute_graphql.md) - executes a graphql call with the registered schema, query, variables and context
- [response](/docs/response.md) - the response, as JSON, of the executed graphql query
- [response_data](/docs/response_data.md) - digs through the graphql response to return data from the specified node(s)

API / Development

- [.add_matcher](/docs/add_matcher.md) - add a custom RSpec matcher to the GraphQLResponse matchers
- [.add_validator](/docs/add_validator.md) - add a custom validator to be used by the custom matchers
- [.add_helper](/docs/add_helper.md) - add helper methods to your specs, made avialable in `it` or `describe` / `context` blocks

## Getting Started

There are only a couple of bits you need to get started:

- configuration of a GraphQL Schema in [`RSpec::GraphQLResponse.configure`](/docs/configuration.md)
- the inclusion of [`type: :graphql`](/docs/graphql_spec_type.md) in your `RSpec.describe` call

```ruby
RSpec::GraphQLResponse.configure do |config|
  config.graphql_schema = MyGraphQLSchema
end

RSpec.describe My::Cool::Thing, type: :graphql do
  # ...
end
```

Beyond these two basic needs, understanding the reason for this gem's existence can be useful in figuring out what the gem
does, and what methods and options are available.

## How We Got Here

Executing a GraphQL call from RSpec is not the most challenging code to write:

```ruby
let(:query) do
  <<-GQL
    query ListCharacters{
      characters {
        id
        name
      }
    }
  GQL
end

subject do
  MySchema.execute(query)
end

it "does something" do
  response = subject.to_h

  # expect(response) ...
end
```

But copy & paste is often considered a design error, and this code is likely going to be littered throughout your spec files.

#### Use the Built-In `execute_graphql`

To help reduce the copy & paste, `RSpec::GraphQLResponse` has a built-in `execute_graphql` method that looks for a `query` variable
in your specs.

```ruby
RSpec.describe Some::Thing, type: :graphql do
  graphql_operation <<-GQL
    query ListCharacters{
      characters {
        id
        name
      }
    }
  GQL

  it "executes the query" do
    response = execute_graphql.to_h

    # expect(response) ...
  end
end
```

#### Use the Built-In `response`

The reduction in code is good, but the copy & paste of `response = execute_graphql.to_h` will quickly become an issue in the same
way. The reduce this, `RSpec::GraphQLResponse` provides a built-in `response` helper.

```ruby
RSpec.describe Some::Thing, type: :graphql do
  graphql_operation <<-GQL
    query ListCharacters{
      characters {
        id
        name
      }
    }
  GQL

  it "executes the query" do
    expect(response).to include(
      "data" => {
        "characters" => { ... }
      }
    )
  end
end
```

#### Retrieve response results with `response_data`

Now that the GraphQL query has been executed and a response has been obtained, it's time to check for the results of a GraphQL
operation. In the previous example, the spec is expecting to find `data` with `characters` in the response hash. To reduce the
nested hash checking, use the built-in `response_data` method to retrieve the `characters`:

```ruby
RSpec.describe Some::Thing, type: :graphql do
  graphql_operation <<-GQL
    query ListCharacters{
      characters {
        id
        name
      }
    }
  GQL

  it "executes the query" do
    expect(response_data :characters).to include(
      # ...
    )
  end
end
```

Note the lack of `response` use here. Internally, the `response_data` method uses the `response` to obtain the data requested. This
means the entire chain of operations from executing the GraphQL request, to converting the response into a hash, and digging
through the results to find the correction operation, has been handled behind the scenes. To see more examples of how to use
`response_data` dig through your response check out it's full documenation [here.](/docs/response_data.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/testdouble/rspec-graphql_response. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::GraphQLResponse project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/testdouble/rspec-graphql_response/blob/master/CODE_OF_CONDUCT.md).
