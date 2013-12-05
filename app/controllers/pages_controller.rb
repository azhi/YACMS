class PagesController < ApplicationController
  load_resource :page, find_by: :clear_url
  authorize_resource :page

  def home
    @page = Setting.home_page
    render 'show'
  end
end
