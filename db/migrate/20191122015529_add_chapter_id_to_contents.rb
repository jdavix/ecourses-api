class AddChapterIdToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :chapter_id, :integer
    add_index :contents, :chapter_id
  end
end
