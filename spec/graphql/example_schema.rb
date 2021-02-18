require "graphql/example_types"
require "graphql/example_queries"

class ExampleSchema < GraphQL::Schema
  query ExampleQueries
end
