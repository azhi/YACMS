module CommentsHelper

  # Returns the form arguments required to create or update the comment
  def comment_form_values(post, comment)
    [post, comment]
  end

end
