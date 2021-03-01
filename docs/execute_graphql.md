# Executing GraphQL with Helper Method `execute_graphql`

Simplifies execution of a graphql query, using `context` / `describe` level helper
methods for configuring the query.

```ruby
RSPec.describe Cool::Stuff, type: :graphql do
  graphql_query <<-GQL
    query SomeThing($name: String) {
      characters(name: $name) {
        id
        name
      }
    }
  GQL
  
  graphql_variables {
    name: "Jam"
  }

  grapql_context {
    current_user: "some user or whatever you need"
  }

  it "executes and does the thing with the vars and context" do
    # ... expect things here
  end
end
```

## Available Configuration Methods

### `graphql_query`

A string - most commonly a ruby heredoc - for the graphql query to execute

### `graphql_variables`

A hash of keys and values that the query expects to use

### `graphql_context`

A hash of keys and values that are passed to a query or mutation, as `context`, in that query or mutation's resolver method.
