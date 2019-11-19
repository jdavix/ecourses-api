class CreateContentFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :content_files do |t|
      t.text :html_text
      t.string :file

      t.timestamps
    end
  end
end
