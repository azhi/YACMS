class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.string :clear_url
      t.boolean :show_in_menu

      t.timestamps
    end
  end
end
