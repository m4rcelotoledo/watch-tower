# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  # JWT auth is stateless; warden has no session user on logout even with a valid token.
  skip_before_action :verify_signed_out_user, only: :destroy

  def destroy
    super
  end
end
