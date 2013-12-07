class Admin::PostsController < Admin::AdminController
  load_resource :post, class_name: 'Post', instance_name: 'post', find_by: :clear_url, except: :add_image
  authorize_resource :post

  include CanAddImage
  include CanAddFile

  def create
    @post.image_ids = session[:added_image_ids].uniq.select{ |image_id| Image.where(id: image_id).exists? }
    @post.attachment_ids = session[:added_file_ids].uniq.select{ |attachment_id| Attachment.where(id: attachment_id).exists? }
    if @post.save
      redirect_to admin_post_path(@post),  notice: "Post was successfully created."
    else
      render action: "new"
    end
  end

  def update
    @post.image_ids += session[:added_image_ids].uniq.select{ |image_id| Image.where(id: image_id).exists? }
    @post.attachment_ids = session[:added_file_ids].uniq.select{ |attachment_id| Attachment.where(id: attachment_id).exists? }
    @post.image_ids.uniq!
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "Post was successfully updated."
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
