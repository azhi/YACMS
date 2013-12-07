class Attachment < ActiveRecord::Base
  dragonfly_accessor :file

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :pages

  after_update :update_dependent_materials

  def update_dependent_materials
    posts.each(&:regenerate_file_srcs!)
    pages.each(&:regenerate_file_srcs!)
  end
end
