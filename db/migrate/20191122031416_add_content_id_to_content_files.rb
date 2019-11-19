class AddContentIdToContentFiles < ActiveRecord::Migration[5.2]
  def change
    add_column :content_files, :content_id, :integer
    add_index :content_files, :content_id
  end
end
