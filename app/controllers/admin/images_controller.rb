class Admin::ImagesController < Admin::AdminController
  load_resource :image
  authorize_resource :image

  def create
    if @image.save
      redirect_to admin_images_path,  notice: "Image was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @image.update(image_params)
      redirect_to admin_images_path, notice: "Image was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @image.destroy

    redirect_to admin_images_url, notice: "Image was successfully deleted."
  end

  protected

  def image_params
    params.require(:image).permit(:name, :image)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_images_url, :alert => exception.message
    end
  end
end
