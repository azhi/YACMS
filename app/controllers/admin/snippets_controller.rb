class Admin::SnippetsController < Admin::AdminController
  load_resource :snippet
  authorize_resource :snippet

  def create
    if @snippet.save
      redirect_to admin_snippet_path(@snippet),  notice: "Snippet was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to admin_snippet_path(@snippet), notice: "Snippet was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @snippet.destroy

    redirect_to admin_snippets_url, notice: "Snippet was successfully deleted."
  end

  protected

  def snippet_params
    params.require(:snippet).permit(:name, :content)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_snippets_url, :alert => exception.message
    end
  end
end
