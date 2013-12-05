module Admin::PostsHelper

  # Returns the form arguments required to create or update the post
  def post_form_values(post)
    [:admin, post]
  end

end
