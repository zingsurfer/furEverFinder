class ApplicationController < ActionController::API
  before_action :set_headers
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_params_response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
  rescue_from ActionController::ParameterMissing, with: :missing_parameter_response

  private

  def missing_parameter_response(error)
    render json: { error: "Invalid payload: #{error.message}." }, status: 422
  end

  def record_not_found_response
    render json: { error: "Record not found." }, status: 404
  end

  def set_headers
    response.set_header("Accept", "application/json")
    response.set_header("Content-Type", "application/json")
  end

  def unpermitted_params_response(error)
    message = "Invalid query parameter(s): #{error.params.to_sentence}. Please verify the query parameter name(s)."
    render json: { error: message }, status: 400
  end
end
