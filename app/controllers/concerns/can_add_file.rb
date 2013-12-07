module CanAddFile
  extend ActiveSupport::Concern

  included do
    respond_to :json, only: :add_file

    before_filter :empty_added_file_ids, only: :new
  end

  def add_file
    @file = Attachment.find(params[:file_id])
    session[:added_file_ids] ||= []
    session[:added_file_ids] << @file.id
    file_url = @file.file.url
    data_params = {id: @file.id}
    render json: {file: "<a href=\"#{file_url}\" \
                         #{data_params.map{ |k, v| "data-file-#{k.to_s.gsub(?_, ?-)}=\"#{v}\"" }.join(' ') } \
                        >#{@file.name}</a>"}
  end

  private

    def empty_added_file_ids
      session[:added_file_ids] = []
    end
end
