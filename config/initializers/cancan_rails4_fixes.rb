module CanCan
  class ControllerResource
    protected

    def resource_params_with_strong_params
      @params[:action].in?(%w[create update]) ? @controller.send("#{name}_params") : resource_params_without_strong_params
    end
    alias_method_chain :resource_params, :strong_params
  end
end
