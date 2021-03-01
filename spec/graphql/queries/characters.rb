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

      current_user = context[:current_user]
      if current_user
        data << {"id" => "4", "name" => current_user }
      end

      if name
        data.select { |c| c["name"] == name }
      else
        data
      end
    end
  end
end
