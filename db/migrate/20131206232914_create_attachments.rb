class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :file_uid
      t.string :file_name

      t.timestamps
    end

    add_index :attachments, :file_uid
    add_index :attachments, :file_name
  end
end
