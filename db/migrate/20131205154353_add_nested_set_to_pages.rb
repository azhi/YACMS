class AddNestedSetToPages < ActiveRecord::Migration
  def change
    add_column :pages, :lft, :integer
    add_column :pages, :rgt, :integer
    add_column :pages, :parent_id, :integer
    add_column :pages, :depth, :integer

    add_index :pages, :lft
    add_index :pages, :rgt
    add_index :pages, :parent_id
    add_index :pages, :depth
  end
end
