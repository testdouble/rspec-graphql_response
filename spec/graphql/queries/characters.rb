module Queries
  class Characters < GraphQL::Schema::Resolver
    type [Types::Response::Character], null: false

    argument :name, String, required: false

    def resolve(name: nil)
      data = [
        {
          "id" => "1",
          "name" => "Jam"
        },
        {
          "id" => "2",
          "name" => "Redemption"
        },
        {
          "id" => "3",
          "name" => "Pet"
        }
      ]

      if name
        data.select { |c| c["name"] == name }
      else
        data
      end
    end
  end
end
