module Types
  module Response
    class Character < GraphQL::Schema::Object
      description "A character from a book, movie, or other show"

      field :id, ID, null: false
      field :name, String, null: false
      field :friends, [Character], null: false
    end
  end
end
