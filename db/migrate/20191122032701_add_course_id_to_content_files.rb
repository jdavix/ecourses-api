class AddCourseIdToContentFiles < ActiveRecord::Migration[5.2]
  def change
    add_column :content_files, :course_id, :integer
    add_index :content_files, :course_id
  end
end
