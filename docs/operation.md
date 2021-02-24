# Using the `operation` helper

The `operation` helper will dig through a response to find a data
structure that looks like, 

```ruby
{
  "data" => {
    operation_name
  }
}
```

## Basic Use

```ruby
it "has characters" do
  characters = operation(:characters)

  expect(character).to include(
    { id: 1, name: "Jam" },
    # ...
  )
end
```

## Handling Nil

If there is no `"data"` or no named operation for the name supplied, the
`operation` helper will return `nil`

```ruby
it "returns nil if operation doesn't exist" do
  character = operation(:something_that_does_not_exist)

  expect(operation).to be_nil
end
```
