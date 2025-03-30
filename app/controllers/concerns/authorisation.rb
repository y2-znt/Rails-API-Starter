module Authorisation
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def pundit_user
    current_user
  end

  private

  def user_not_authorized
    render json: {error: "You are not authorized to perform this action."}, status: :forbidden
  end
end
