class Admin::PagesController < Admin::AdminController
  load_resource :page, class_name: 'Page', instance_name: 'page', find_by: :clear_url, except: [:index, :rebuild]
  authorize_resource :page

  include TheSortableTreeController::Rebuild
  include CanAddImage
  include CanAddFile

  def index
    @pages = Page.nested_set.select('id, name, title, parent_id, clear_url').all
  end

  def create
    @page.image_ids = session[:added_image_ids].uniq.select{ |image_id| Image.where(id: image_id).exists? }
    @page.attachment_ids = session[:added_file_ids].uniq.select{ |attachment_id| Attachment.where(id: attachment_id).exists? }
    if @page.save
      redirect_to admin_page_path(@page),  notice: "Page was successfully created."
    else
      render action: "new"
    end
  end

  def update
    @page.image_ids = session[:added_image_ids].uniq.select{ |image_id| Image.where(id: image_id).exists? }
    @page.attachment_ids = session[:added_file_ids].uniq.select{ |attachment_id| Attachment.where(id: attachment_id).exists? }
    if @page.update(page_params)
      redirect_to admin_page_path(@page), notice: "Page was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @page.destroy

    redirect_to admin_pages_url, notice: "Page was successfully deleted."
  end

  protected

  def page_params
    params.require(:page).permit(:name, :title, :body, :show_in_menu, :parent_id)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_pages_url, :alert => exception.message
    end
  end
end
