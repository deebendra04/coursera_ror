class CreateCourseContents < ActiveRecord::Migration[6.1]
  def up
    create_table :course_contents do |t|
      t.string :title, null: false
      t.text :description
      t.string :content_type, null: false
      t.string :content_url, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :course_contents
  end
end
