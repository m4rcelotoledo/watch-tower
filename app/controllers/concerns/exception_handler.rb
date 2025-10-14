# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |error|
      json_response({ message: error.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      json_response({ message: error.message }, :unprocessable_content)
    end

    rescue_from ActionController::ParameterMissing do |error|
      json_response({ message: error.message }, :bad_request)
    end

    rescue_from CanCan::AccessDenied do |error|
      json_response({ message: error.message }, :unauthorized)
    end
  end
end
