class Admin::SettingsController < Admin::AdminController
  authorize_resource :setting

  def edit
    @settings = Setting.first || Setting.new
  end

  def update
    @settings = Setting.first || Setting.new
    if @settings.update(setting_params)
      redirect_to edit_admin_setting_path, notice: "Settings was successfully updated."
    else
      render action: "edit"
    end
  end

  protected

  def setting_params
    params.require(:setting).permit(:home_page_id, :company_name, :enable_menu, :enable_blog)
  end
end
