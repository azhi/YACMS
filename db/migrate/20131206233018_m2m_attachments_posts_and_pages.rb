class M2mAttachmentsPostsAndPages < ActiveRecord::Migration
  def change
    create_table :attachments_posts do |t|
      t.belongs_to :attachment
      t.belongs_to :post
    end

    create_table :attachments_pages do |t|
      t.belongs_to :attachment
      t.belongs_to :page
    end
  end
end
