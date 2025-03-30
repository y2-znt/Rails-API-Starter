class MeSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :created_at, :updated_at
  attribute :role, if: :admin_view?

  def admin_view?
    scope&.admin?
  end
end
