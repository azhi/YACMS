class Admin::UsersController < Admin::AdminController
  load_resource :user, class_name: 'User', instance_name: 'user'
  authorize_resource :user

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_url, notice: "User was successfully deleted."
  end

  protected

  def user_params
    params.require(:user).permit(:role)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_users_url, :alert => exception.message
    end
  end
end
