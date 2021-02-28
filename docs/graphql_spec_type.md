# Custom Spec Type, `type: :grapql`

To use the custom helpers and matchers provide by RSpec::GraphQLResponse, you need to specificy `type: :graphql` as 
part of your spec's description.

```ruby
RSpec.describe My::Cool::Thing, type: :graphql do

  # ... all of RSpec::GraphQLResponse is now available!

end
```

With this `type` set, your specs will have access to all of the `RSpec::GraphQLResponse` features.
