class CommentsController < ApplicationController
  load_resource :post, find_by: :clear_url
  load_resource :comment, through: :post
  authorize_resource :comment

  def new
    @comment.parent_id = params[:parent_id]
  end

  def create
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@comment.post),  notice: "Comment was successfully created."
    else
      render action: "new"
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
