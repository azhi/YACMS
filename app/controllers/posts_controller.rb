class PostsController < ApplicationController
  load_resource :post, find_by: :clear_url
  authorize_resource :post
end
