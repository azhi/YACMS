class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end

    add_index :images, :image_uid
    add_index :images, :image_name
  end
end
