class CreateProgresses < ActiveRecord::Migration[6.1]
  def up
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_content, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.timestamps
    end
  end

  def down
    drop_table :progresses
  end
end
