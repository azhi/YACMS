class Admin::AttachmentsController < Admin::AdminController
  load_resource :attachment
  authorize_resource :attachment

  def create
    if @attachment.save
      redirect_to admin_attachments_path,  notice: "File was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @attachment.update(attachment_params)
      redirect_to admin_attachments_path, notice: "File was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @attachment.destroy

    redirect_to admin_attachments_url, notice: "File was successfully deleted."
  end

  protected

  def attachment_params
    params.require(:attachment).permit(:name, :file)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_attachments_url, :alert => exception.message
    end
  end
end
