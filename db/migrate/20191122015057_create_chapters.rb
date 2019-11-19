class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :title
      t.integer :course_id

      t.timestamps
    end
    add_index :chapters, :course_id
  end
end
