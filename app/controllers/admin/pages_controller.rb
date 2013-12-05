class Admin::PagesController < Admin::AdminController
  load_resource :page, class_name: 'Page', instance_name: 'page', find_by: :clear_url, except: [:index, :rebuild]
  authorize_resource :page

  include TheSortableTreeController::Rebuild

  def index
    @pages = Page.nested_set.select('id, name, title, parent_id, clear_url').all
  end

  def create
    if @page.save
      redirect_to admin_page_path(@page),  notice: "Page was successfully created."
    else
      render action: "new"
    end
  end

  def update
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
