module CanAddSnippet
  extend ActiveSupport::Concern

  included do
    respond_to :json, only: :add_snippet

    before_filter :empty_added_snippet_ids, only: [:new, :edit]
  end

  def add_snippet
    @snippet = Snippet.find(params[:snippet_id])
    session[:added_snippet_ids] ||= []
    session[:added_snippet_ids] << @snippet.id
    content = @snippet.render_content
    data_params = {id: @snippet.id}
    render json: {snippet: "<span #{data_params.map{ |k, v| "data-snippet-#{k.to_s.gsub(?_, ?-)}=\"#{v}\"" }.join(' ') }> \
                            #{content}</span>"}
  end

  private

    def empty_added_snippet_ids
      session[:added_snippet_ids] = []
    end
end
