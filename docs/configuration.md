# RSpec::GraphQLResponse Configuration

To get things rolling, add a configuration block to your `spec_helper.rb` (or other file that gets included in specs, as
desired). Within this block, you'll need to provide the GraphQL Schema to use for query execution.

```ruby
RSpec::GraphQLResponse.configure |config| do

  config.graphql_schema = MyGraphQLSchema

end
```
