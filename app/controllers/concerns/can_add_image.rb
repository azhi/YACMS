module CanAddImage
  extend ActiveSupport::Concern

  included do
    respond_to :json, only: :add_image

    before_filter :empty_added_image_ids, only: [:new, :edit]
  end

  def add_image
    @image = Image.find(params[:image_id])
    session[:added_image_ids] ||= []
    session[:added_image_ids] << @image.id
    image_url = params[:enable_resizing] == 'true' ?
                  @image.image.thumb("#{params[:resizing_width]}x#{params[:resizing_height]}").url :
                  @image.image.url
    data_params = {id: @image.id}
    [:width, :height].each do |dim|
      data_params[:"resizing_#{dim}"] = params[:"resizing_#{dim}"] if params[:enable_resizing] == 'true'
    end
    render json: {img: "<img src=\"#{image_url}\" \
                         #{data_params.map{ |k, v| "data-image-#{k.to_s.gsub(?_, ?-)}=\"#{v}\"" }.join(' ') } \
                        />"}
  end

  private

    def empty_added_image_ids
      session[:added_image_ids] = []
    end
end
