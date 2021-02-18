require "graphql/queries/characters"

class ExampleQueries < Types::BaseObject
  graphql_name "Query"

  field :characters, resolver: Queries::Characters
end
