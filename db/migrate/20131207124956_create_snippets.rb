class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :content

      t.timestamps
    end

    add_index :snippets, :name
  end
end
