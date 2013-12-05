module RenderNestedOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]

        this_node      = options[:selected] == node
        selected_class = this_node ? ' selected' : nil
        selected       = this_node ? " selected='selected'" : nil


        "
        <option value='#{node[:id]}' class='#{selected_class}' #{selected}>#{ '|&ndash; ' * (options[:level] - 1) + node.send(options[:title]) }</option>
        #{ options[:children] }
        "
      end

    end
  end
end