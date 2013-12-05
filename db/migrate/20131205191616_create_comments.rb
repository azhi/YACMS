class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :post_id
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end

    add_index :comments, :lft
    add_index :comments, :rgt
    add_index :comments, :parent_id
    add_index :comments, :depth
  end
end
