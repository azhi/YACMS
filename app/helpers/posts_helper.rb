module PostsHelper
  def index_post_entry(post, last = false)
    body = post.body.split(Post.template_variables[:cut][:placeholder]).first
    body += link_to('Read more...', post)
    body += '<p>Published at: ' + post.created_at.to_s + '</p>'
    body += '<hr />' unless last
    body
  end
end
