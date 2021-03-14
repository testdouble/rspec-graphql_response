# Using the `response_data` Helper

The `response_data` helper will dig through a graphql response, through
the outer hash, into the response data for an operation, and through any
and all layers of hash and array. 

## Basic Use

A `response` data structure may look something like the following.

```ruby
{
  "data" => {
    "characters" => [
      { "id" => "1", "name" => "Jam" },
      { "id" => "2", "name" => "Redemption" },
      { "id" => "3", "name" => "Pet" }
    ]
  }
}
```

The `response_data` helper will dig through to give you simplified
results that are easier to verify.

For example, if only the names of the characters need to be checked:

```ruby
response_data :characters, :name

# => ["Jam", "Redemption", "Pet"]
```

Or perhaps only the name for 2nd character is needed:

```ruby
response_data {characters: [1]}, :name

# => "Redemption"
```

## List Every Item in an Array

Many responses from a graphql call will include an array of data somewhere
in the data structure. If you need to return all of the items in an array,
you only need to specify that array's key:

```ruby
it "has characters" do
  characters = response_data(:characters)

  expect(character).to include(
    { id: 1, name: "Jam" },
    # ...
  )
end
```

## Dig a Field From Every Item in an Array

When validation only needs to occur on a specific field for items found in
an array, there are two options.

1. Specify a list of fields as already shown
2. change the array's key to a hash and provide a `:symbol` wrapped in an array as the value

The first option was already shown in the Basic Use section above. 

```ruby
response_data :characters, :name

# => ["Jam", "Redemption", "Pet"]
```

For the second option, the code would look like this:

```ruby
response_data characters: [:name]

# => ["Jam", "Redemption", "Pet"]
```

Both of these options are functionaly the same. The primary difference will be
how you wish to express the data structure in your code. Changing the list of
attributes to a hash with an array wrapping the value will provide a better
indication that an array is expected at that point in the data structure.

## Dig Out an Item By Index, From an Array

There may be times when only a single piece of a returned array needs to be
validated. To handle this, switch the key of the array to a hash, as in the
previous example. Rather than specifying a child node's key in the value, though,
specify the index of the item you wish to extract.

```ruby
response_data characters: [1]
```

This will return the character at index 1, from the array of characters.

## Handling Nil

If there is no data the key supplied, the helper will return `nil`

```ruby
response_data(:something_that_does_not_exist) #=> nil
```
