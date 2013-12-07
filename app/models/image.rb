class Image < ActiveRecord::Base
  dragonfly_accessor :image

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :pages

  after_update :update_dependent_materials

  def update_dependent_materials
    posts.each(&:regenerate_images!)
    pages.each(&:regenerate_images!)
  end
end
