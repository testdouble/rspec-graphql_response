module Queries
  class Characters < GraphQL::Schema::Resolver
    type Types::Response::Character

    def resolve
      []
    end
  end
end
