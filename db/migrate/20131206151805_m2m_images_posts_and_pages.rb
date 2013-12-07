class M2mImagesPostsAndPages < ActiveRecord::Migration
  def change
    create_table :images_posts do |t|
      t.belongs_to :image
      t.belongs_to :post
    end

    create_table :images_pages do |t|
      t.belongs_to :image
      t.belongs_to :page
    end
  end
end
