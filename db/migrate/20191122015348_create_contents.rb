class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :content_type
      t.integer :order

      t.timestamps
    end
    add_index :contents, :order
  end
end
