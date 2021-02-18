module Queries
  class Characters < GraphQL::Schema::Resolver
    type Types::Response::Character, null: false

    def resolve
      []
    end
  end
end
