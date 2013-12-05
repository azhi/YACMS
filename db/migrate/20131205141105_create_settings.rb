class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :home_page_id
      t.boolean :enable_blog
      t.boolean :enable_menu

      t.timestamps
    end
  end
end
