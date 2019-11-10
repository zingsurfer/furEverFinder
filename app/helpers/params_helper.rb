module ParamsHelper
  class UnpermittedParamValue < RuntimeError
    attr_reader :key, :value
    def initialize(key:, value:)
      @key = key
      @value = value
    end
  end

  class UnsupportedParamCombo < RuntimeError
    attr_reader :params
    def initialize(params:)
      @params = params
    end
  end

  private

  def unpermitted_param_value_response(exception)
    message = "Unpermitted value for #{exception.key}: #{exception.value}. Please verify the query parameter value(s)."
    render json: { error: message }, status: 422
  end

  def unsupported_param_combo_response(exception)
    message = "Query parameter combo is currently unsupported: #{exception.params.to_sentence}."
    render json: { error: message }, status: 400
  end
end
