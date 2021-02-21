module Queries
  class Characters < GraphQL::Schema::Resolver
    type [Types::Response::Character], null: false

    def resolve
      [
        {
          id: 1,
          name: "Jam"
        },
        {
          id: 2,
          name: "Redemption"
        },
        {
          id: 3,
          name: "Pet"
        }
      ]
    end
  end
end
