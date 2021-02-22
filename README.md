# Rspec::GraphQLResponse

RSpec::GraphQLResponse provides a series of RSpec matchers, helper methods, and other configuration to help simplify
the testing of responses from the `graphql-ruby` gem and the `<GraphQLSchemaName>.execute` method.

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

The full documentation for RSpec::GraphQLResponse can be found in the `/docs`
folder.

* [have_errors matcher](/docs/have_errors.md)

## Configuration

To get things rolling, add a configuration block to your `spec_helper.rb` (or other file that gets included in specs, as
desired). Within this block, you'll need to provide the GraphQL Schema to use for query execution.


```ruby
RSpec::GraphQLResponse.configure |config| do

  config.graphql_schema = MyGraphQLSchema

end
```

## Getting Started

There are a number of built-in helper methods and matchers that will allow you to skip the copy & paste work of executing
a GraphQL Schema `.execute`. These include:

Spec types:

* `type: :graphql`

Helper methods:

* `execute_graphql`
* `response`
* `operation`

Matchers:

* `have_errors`

### The `:graphql` Spec Type

To use these custom helpers and matchers, you need to specificy `type: :graphql` as part of your spec's description. For exmaple,

```ruby
RSpec.describe Some::Thing, type: :graphql do

  # ... 

end
```

With this `type` set, your specs will have access to all of the `RSpec::GraphQLResponse` code.

### Helper Methods

Executing a GraphQL call from RSpec is not the most challening code to write:

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
  let(:query) do
    <<-GQL
      query {
        characters {
          id
          name
        }
      }
    GQL
  end

  it "executes the query" do
    expect(response).to include(
      "data" => {
        "characters" => { ... }
      }
    )
  end
end
```

#### Retrieve operation results with `operation`

Now that the GraphQL query has been executed and a response has been obtained, it's time to check for the results of a GraphQL
operation. In the previous example, the spec is expecting to find `data` with `characters` in the response hash. To reduce the
nested hash checking, use the built-in `operation` method to retrieve the `characters`:

```ruby
RSpec.describe Some::Thing, type: :graphql do
  let(:query) do
    <<-GQL
      query {
        characters {
          id
          name
        }
      }
    GQL
  end

  it "executes the query" do
    characters = operation(:characters)

    expect(characters).to include(
      # ... 
    )
  end
end
```

Note the lack of `response` use here. Internally, the `operation` method uses the `response` to obtain the data requested. This
means the entire chain of operations from executing the GraphQL request, to converting the response into a hash, and digging
through the results to find the correction operation, has been handled behind the scenes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/testdouble/rspec-graphql_response. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::GraphQLResponse project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/testdouble/rspec-graphql_response/blob/master/CODE_OF_CONDUCT.md).
