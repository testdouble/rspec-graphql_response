# Validate a response operation with `have_operation(name)`

Check for the presence of an operation's results. Useful when you want to ensure an operation exists before
retrieving the operation's results.

## Validate an Operation is Present

```ruby
RSpec.describe My::Characters, type: :graphql do
  graphql_operation <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  it "has the characters" do

    expect(response).to have_operation(:characters)

  end
end
```

## Validate an operation is NOT Present

```ruby
RSpec.describe My::Characters, type: :graphql do
  graphql_operation <<-GQL
    query CharacterList {
      characters {
        id
        name
      }
    }
  GQL

  it "does not have books" do

    expect(response).to_not have_operation(:books)

  end
end
```
