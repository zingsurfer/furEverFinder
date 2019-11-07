class ApplicationController < ActionController::API
  before_action :set_headers

  rescue_from ActionController::UnpermittedParameters do |error|
    message = "Invalid query parameter(s): #{error.params.to_sentence}. Please verify the query parameter name(s)."
    render json: { error: message }, status: 400
  end

  private

  def set_headers
    response.set_header("Accept", "application/json")
    response.set_header("Content-Type", "application/json")
  end
end
