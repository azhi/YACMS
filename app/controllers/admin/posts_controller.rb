class Admin::PostsController < Admin::AdminController
  load_resource :post, class_name: 'Post', instance_name: 'post', find_by: :clear_url
  authorize_resource :post

  def create
    if @post.save
      redirect_to admin_post_path(@post),  notice: "Post was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @post.destroy

    redirect_to admin_posts_url, notice: "Post was successfully deleted."
  end

  protected

  def post_params
    params.require(:post).permit(:title, :body, :allow_commentaries)
  end

  # Capture any access violations, ensure User isn't unnessisarily redirected to root
  rescue_from CanCan::AccessDenied do |exception|
    if params[:action] == 'index'
      redirect_to root_url, :alert => exception.message
    else
      redirect_to admin_posts_url, :alert => exception.message
    end
  end
end
