class MeSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :created_at, :updated_at
end
