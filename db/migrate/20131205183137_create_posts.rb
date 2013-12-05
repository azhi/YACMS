class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :clear_url
      t.boolean :allow_commentaries

      t.timestamps
    end
  end
end
