<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<%-

#
# Available properties:
# 
#   class_name
#   controller_class_name
#   singular_table_name
#   file_name
#   human_name
#   orm_instance
#   route_url
#

t_helper = AuthorizedRailsScaffolds::RailsScaffoldControllerHelper.new(
  :class_name => class_name,
  :human_name => human_name,
  :controller_class_name => controller_class_name,
  :singular_table_name => singular_table_name,
  :file_name => file_name
)

resource_class = t_helper.resource_class # Non-Namespaced class name
resource_human_name = t_helper.resource_human_name
resource_symbol = t_helper.resource_symbol
resource_key = t_helper.resource_key
resource_name = t_helper.resource_name
resource_array_name = t_helper.resource_array_name
resource_var = t_helper.resource_var
resource_array_key = t_helper.resource_array_key
resource_array_var = t_helper.resource_array_var # Pluralized non-namespaced variable name

example_index_path = t_helper.example_index_path
example_show_path = t_helper.example_show_path

# Override default orm instance
orm_instance = Rails::Generators::ActiveModel.new resource_name

-%>
<% module_namespacing do -%>
class <%= t_helper.controller_class_name %> < <%= t_helper.application_controller_class %>
  <%- t_helper.parent_model_names.each_with_index do |model_name, model_index| -%>
  <%= t_helper.load_and_authorize_parent model_name %>
  <%- end -%>
  <%= t_helper.load_resource %>
<%- if t_helper.shallow_routes? -%>
  before_filter :load_shallow_resources
<%- end -%>
  authorize_resource <%= resource_symbol %>

  def create
    if @<%= orm_instance.save %>
      redirect_to <%= t_helper.controller_show_route(resource_var) %>,  notice: "<%= resource_human_name %> was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @<%= orm_instance.update_attributes("#{resource_name}_params") %>
      redirect_to <%= t_helper.controller_show_route resource_var %>, notice: "<%= resource_human_name %> was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @<%= orm_instance.destroy %>

    redirect_to <%= t_helper.controller_index_route %>, notice: "<%= resource_human_name %> was successfully deleted."
  end

  protected
<%- if t_helper.shallow_routes? -%>

  # Loads parent resources from <%= resource_var %> if not included in route
  def load_shallow_resources
<%- reverse_parent_models = t_helper.parent_model_names.reverse -%>
<%- reverse_parent_models.each_with_index do |parent_model, parent_index| -%>
  <%- if parent_index == 0 -%>
    if <%= resource_var %> && <%= resource_var %>.persisted?
      <%= t_helper.parent_variable(parent_model) %> = <%= resource_var %>.<%= parent_model %> if <%= t_helper.parent_variable(parent_model) %>.nil?
    end
  <%- else -%>
    if <%= t_helper.parent_variable(reverse_parent_models[parent_index-1]) %> && <%= t_helper.parent_variable(parent_model) %>.nil?
      <%= t_helper.parent_variable(parent_model) %> = <%= t_helper.parent_variable(reverse_parent_models[parent_index-1]) %>.<%= parent_model %>
    end
  <%- end -%>
<%- end -%>
  end
<%- end -%>

  def <%= resource_name %>_params
  <%- if attributes_names.empty? -%>
    params[:<%= singular_table_name %>]
  <%- else -%>
    params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
  <%- end -%>
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'<%= t_helper.parent_model_names.collect { |parent_model| " or #{t_helper.parent_variable(parent_model)}.nil?" }.join('') %>
      redirect_to root_url, :alert => exception.message
    else
      redirect_to <%= t_helper.controller_index_route %>, :alert => exception.message
    end
  end
end
<% end -%>
