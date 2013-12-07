class M2mSnippetsPostsAndPages < ActiveRecord::Migration
  def change
    create_table :posts_snippets do |t|
      t.belongs_to :post
      t.belongs_to :snippet
    end

    create_table :pages_snippets do |t|
      t.belongs_to :page
      t.belongs_to :snippet
    end
  end
end
