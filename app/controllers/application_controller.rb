class ApplicationController < ActionController::API
  rescue_from ActionController::UnpermittedParameters do |error|
    message = "Invalid query parameter(s): #{error.params.to_sentence}. Please verify the query parameter name(s)."
    render json: { error: message }, status: 400
  end
end
